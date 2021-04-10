####################################
# IMPORTS
####################################
import argparse
import os
import re
import subprocess

####################################
# GLOBALS / CONSTANTS
####################################
FFMPEG = "ffmpeg"
RAW_YUV_FILE = "rawbitstream.yuv"
RAW_YUV_ALPHA_FILE = "rawbitstream_alpha.yuv"
DOWNSAMPLED_YUV_FILE = "rawbitstream_downsampled.yuv"
DOWNSAMPLED_YUV_ALPHA_FILE = "rawbitstream_downsampled_alpha.yuv"

####################################
# HELPER FUNCTIONS
####################################
def deleteTempFiles():
    if os.path.exists(RAW_YUV_FILE):
        os.remove(RAW_YUV_FILE)

    if os.path.exists(RAW_YUV_ALPHA_FILE):
        os.remove(RAW_YUV_ALPHA_FILE)

    if os.path.exists(DOWNSAMPLED_YUV_FILE):
        os.remove(DOWNSAMPLED_YUV_FILE)

    if os.path.exists(DOWNSAMPLED_YUV_ALPHA_FILE):
        os.remove(DOWNSAMPLED_YUV_ALPHA_FILE)

def getSpecs(gifFile):
    out = ""
    command = [ FFMPEG
              , "-hide_banner"
              , "-i", gifFile
              , "-f", "null"
              , "-"
              ]
    try:
        out = subprocess.check_output(command, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print e.cmd
        print e.output
        return None
    return re.search(r'Stream #0:\d+: Video: .* (\d+)x(\d+)(?=,).*(\d+\.?\d+?)(?= fp)', out)

def convertToRawYUV(gifFile, extractAlpha, verbose):
    out = ""
    command = [ FFMPEG
              , "-hide_banner"
              , "-i", gifFile
              , "-an"
              , "-vcodec", "rawvideo"
              , "-pix_fmt", "yuv420p"
              , RAW_YUV_FILE
              ]
    try:
        out = subprocess.check_output(command, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print e.cmd
        print e.output
        return e.returncode
    if verbose:
        print out

    if extractAlpha:
        out = ""
        command = [ FFMPEG
                  , "-hide_banner"
                  , "-i", gifFile
                  , "-an"
                  , "-vcodec", "rawvideo"
                  , "-vf", "alphaextract"
                  , "-pix_fmt", "yuv420p"
                  , RAW_YUV_ALPHA_FILE
                  ]
        try:
            out = subprocess.check_output(command, stderr=subprocess.STDOUT)
        except subprocess.CalledProcessError as e:
            print e.cmd
            print e.output
            return e.returncode
        if verbose:
            print out
    return 0

def downsampleRawYUV(rawVideo, downsampledVideo, skipRate, width, height, verbose):
    out = ""
    command = [ FFMPEG
              , "-hide_banner"
              , "-r", "%d" % skipRate
              , "-s", "%dx%d" % (width, height)
              , "-i", rawVideo
              , "-filter:v", "select='not(mod(n-1\\,%d))'" % skipRate
              , "-an"
              , "-r", "1"
              , "-vcodec", "rawvideo"
              , "-pix_fmt", "yuv420p"
              , "-f", "rawvideo"
              , downsampledVideo
              ]
    try:
        out = subprocess.check_output(command, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print e.cmd
        print e.output
        return e.returncode
    if verbose:
        print out
    return 0

def convertRawToY4M(rawVideo, videoFile, width, height, verbose):
    out = ""
    command = [ FFMPEG
              , "-hide_banner"
              , "-r", "1"
              , "-s", "%dx%d" % (width, height)
              , "-i", rawVideo
              , "-r", "1"
              , "-s", "%dx%d" % (width, height)
              , "-vf", "format=yuv420p"
              , "-f", "yuv4mpegpipe"
              , videoFile
              ]
    try:
        out = subprocess.check_output(command, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print e.cmd
        print e.output
        return e.returncode
    if verbose:
        print out
    return 0

####################################
# MAIN
####################################
width = -1
height = -1
inputFps = -1

parser = argparse.ArgumentParser( description = 'Generate an Optimized YUV Video File from a GIF File' )
parser.add_argument( 'file', help='source GIF file' )
parser.add_argument( '-a', '--extractalpha', dest='extractAlpha', action='store_true', help='extract an alpha channel from the provided GIF file' )
parser.add_argument( '-r', '--framerate', dest='frameRate', type=int, default=10, help='target frame rate (frames will be skipped if the provided GIF fps is higher than the target rate, defaults to 10 fps)' )
parser.add_argument( '-v', '--verbose', dest='verbose', action='store_true', help='display processing information' )

# Parse the arguments
args = parser.parse_args()
gifFile = args.file
frameRate = args.frameRate
extractAlpha = args.extractAlpha
verbose = args.verbose

deleteTempFiles()

if not os.path.exists(gifFile):
    print "Could not resolve file '%r'.\nExiting." % gifFile
    exit()

if not gifFile.lower().endswith(".gif"):
    print "Unsupported file format provided. Expected a GIF file.\nExiting."
    exit()

# Get the specs of the provided GIF file
specs = getSpecs(gifFile)
if specs:
    width = int(specs.group(1))
    height = int(specs.group(2))
    inputFps = int(specs.group(3))
else:
    print "Could not determine the dimensions / input frame rate of the provided GIF file.\nExiting."
    exit()

# Get the skip rate (input fps / output fps)
skipRate = 1
if inputFps < 0:
    print "Could not determine the input frame rate of the provided GIF file.\nExiting."
    exit()
elif inputFps > 0:
    skipRate = int(inputFps / frameRate)

# Convert the GIF to a raw bitstream
if convertToRawYUV(gifFile, extractAlpha, verbose) > 0:
    print "Could not convert the GIF file to a raw bitstream.\nExiting."
    deleteTempFiles()
    exit()
rawVideo = RAW_YUV_FILE
rawAlphaVideo = RAW_YUV_ALPHA_FILE

# Downsample the raw bitstream if possible
if skipRate > 1:
    if downsampleRawYUV(RAW_YUV_FILE, DOWNSAMPLED_YUV_FILE, skipRate, width, height, verbose) > 0:
        print "Could not downsample the raw bitream.\nExiting."
        deleteTempFiles()
        exit()
    rawVideo = DOWNSAMPLED_YUV_FILE
    if extractAlpha:
        if downsampleRawYUV(RAW_YUV_ALPHA_FILE, DOWNSAMPLED_YUV_ALPHA_FILE, skipRate, width, height, verbose) > 0:
            print "Could not downsample the raw bitream.\nExiting."
            deleteTempFiles()
            exit()
        rawAlphaVideo = DOWNSAMPLED_YUV_ALPHA_FILE

videoFile = "%s.y4m" % os.path.splitext(gifFile)[0]
if os.path.exists(videoFile):
    os.remove(videoFile)

videoAlphaFile = "%s_alpha.y4m" % os.path.splitext(gifFile)[0]
if os.path.exists(videoAlphaFile):
    os.remove(videoAlphaFile)

# Convert the raw bitstream to YUV
if convertRawToY4M(rawVideo, videoFile, width, height, verbose) > 0:
    print "Could not convert the raw bitream to a YUV video file.\nExiting."
    deleteTempFiles()
    exit()
if extractAlpha:
    if convertRawToY4M(rawAlphaVideo, videoAlphaFile, width, height, verbose) > 0:
        print "Could not convert the raw bitream to a YUV video file.\nExiting."
        deleteTempFiles()
        exit()
print "Successfully converted video file: %s" % videoFile
if extractAlpha:
    print "Successfully converted alpha video file: %s" % videoAlphaFile

deleteTempFiles()
