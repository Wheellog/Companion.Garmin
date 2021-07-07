using Toybox.WatchUi;
using Toybox.Application.Properties;
using Toybox.Application.Storage;
using Toybox.System;

class ArcRenderer extends WatchUi.Drawable {
    private var mMainColor,
        mSecondColor,
        mThirdColor,
        mStartDegree,
        mEndDegree,
        mXCenterPosition,
        mYCenterPosition,
        mArcRadius,
        mArcSize,
        mArcDirection,
        mArcType,
        mDataDrawingDirection;

    var currentValue = 0, maxValue = 0;

    private var screenCenterX = System.getDeviceSettings().screenWidth / 2;
    private var screenCenterY = System.getDeviceSettings().screenHeight / 2;

    private var screenHeight = System.getDeviceSettings().screenHeight;
    private var screenWidth = System.getDeviceSettings().screenWidth;

    var font = WatchUi.loadResource(Rez.Fonts.Tall);

    function initialize(params) {
        Drawable.initialize(params);
        
        mArcType = params[:arcType];
        mMainColor = params.get(:mainColor);
        mSecondColor = params.get(:secondColor);
        if (mArcType != :batteryArc) {
            mThirdColor = params[:thirdColor];
        }
        mStartDegree = params.get(:startDegree);
        mEndDegree = params.get(:endDegree);
        if (params.get(:xCenterPosition) == :center) {
            mXCenterPosition = screenCenterX;
        } else {
            mXCenterPosition = params.get(:xCenterPosition);
        }

        if (params.get(:yCenterPosition) == :center) {
            mYCenterPosition = screenCenterY;
        } else {
            mYCenterPosition = params.get(:yCenterPosition);
        }

        if (params.get(:arcRadius) == :max) {
            mArcRadius = screenWidth / 2;
        } else {
            mArcRadius = params.get(:arcRadius);
        }
        mArcSize = params.get(:arcSize);
        mArcDirection = params[:arcDirection];
        mDataDrawingDirection = params.get(:dataDrawingDirection);
    }
    
    function draw(dc) {
        var backgroundColor;
        if (AppStorage.getValue("AppTheme") == 0) {
            backgroundColor = Graphics.COLOR_LT_GRAY;
        } else {
            backgroundColor = Graphics.COLOR_DK_GRAY;
        }
        dc.setPenWidth(mArcSize);

        var foregroundColor;
        if (currentValue != 0.0 && mArcType == :speedArc) {
            if (WheelData.pwm.toNumber() >= AppStorage.getValue("OrangeColoringThreshold") && WheelData.pwm.toNumber() < AppStorage.getValue("RedColoringThreshold")) {
                foregroundColor = mSecondColor;
            } else if (WheelData.pwm.toNumber() >= AppStorage.getValue("RedColoringThreshold")) {
                foregroundColor = mThirdColor;
            } else {
                foregroundColor = mMainColor;
            }
        } else {
            foregroundColor = mMainColor;
        }

        // Calculating position of the foreground 
        // About this part... Oh boy, don't even try to understand what is here,
        // because I just don't care about readability here, bc if it works - don't
        // touch it, and i have a spent a lot of nerves while trying to code this 
        // crap

        dc.setColor(backgroundColor, 0x000000);
        dc.drawArc(mXCenterPosition, mYCenterPosition, mArcRadius, Graphics.ARC_CLOCKWISE, mStartDegree, mEndDegree);
        dc.setColor(foregroundColor, 0x000000);

        switch (mArcType) {
            case :speedArc: {
                if(currentValue >= maxValue) {
                    dc.drawArc(mXCenterPosition, mYCenterPosition, mArcRadius, Graphics.ARC_CLOCKWISE, mStartDegree, mEndDegree);
                } else {
                    var degreeRange = mStartDegree.abs() + mEndDegree.abs();
                    var percentage = currentValue.toFloat() / maxValue.toFloat();
                    var preResult = degreeRange * percentage;
                    var result = mStartDegree - preResult;
                    if (result != mStartDegree) {
                        dc.drawArc(mXCenterPosition, mYCenterPosition, mArcRadius, mArcDirection, mStartDegree, result);
                    }
                }
                break;
            }
            case :batteryArc: {
                if(currentValue >= maxValue) {
                    dc.drawArc(mXCenterPosition, mYCenterPosition, mArcRadius, Graphics.ARC_CLOCKWISE, mStartDegree, mEndDegree);
                } else {
                    var degreeRange = mStartDegree - mEndDegree;
                    var percentage = currentValue.toFloat() / maxValue.toFloat();
                    var result = degreeRange - (degreeRange * percentage) + mEndDegree;
                    if (result != mStartDegree) {
                        dc.drawArc(mXCenterPosition, mYCenterPosition, mArcRadius, mArcDirection, mStartDegree, result);
                    }
                }
                break;
            }
            case :temperatureArc: {
                if(currentValue >= maxValue) {
                    dc.drawArc(mXCenterPosition, mYCenterPosition, mArcRadius, Graphics.ARC_CLOCKWISE, mStartDegree, mEndDegree);
                } else {
                    var degreeRange = mStartDegree.abs() + mEndDegree.abs();
                    var percentage = currentValue.toFloat() / maxValue.toFloat();
                    var preResult = degreeRange * percentage;
                    var result = preResult + mEndDegree;
                    if (result != mEndDegree) {
                        dc.drawArc(mXCenterPosition, mYCenterPosition, mArcRadius, mArcDirection, mEndDegree, result);
                    }
                }
                break;
            }
        }
    }

    function setValues(current, max) {
        currentValue = current;
        maxValue = max;
    }
}