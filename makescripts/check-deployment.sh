if [ -f /Volumes/GARMIN/GARMIN/APPS/WheelLogGarminApp.prg ]; then
    echo "App exists on end device, ready for use!"
else 
    echo "App does not exist, you need to deploy it."
    exit 1
fi
