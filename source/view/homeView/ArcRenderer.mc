using Toybox.WatchUi;
using Toybox.Application.Properties;
using Toybox.Application.Storage;

class ArcRenderer extends WatchUi.Drawable {
    var mCurrent, mMaxValue;

    private var mIdleColor,
        mNormalColor,
        mMediumColor,
        mDangerousColor,
        mStartDegree,
        mEndDegree,
        mXCenterPosition,
        mYCenterPosition,
        mArcRadius,
        mArcSize,
        mArcDirection,
        mArcType,
        mDataDrawingDirection,
        mDataSource,
        mDataSourceMaxValue;

    private var screenCenterX = System.getDeviceSettings().screenWidth / 2;
    private var screenCenterY = System.getDeviceSettings().screenHeight / 2;

    private var screenHeight = System.getDeviceSettings().screenHeight;
    private var screenWidth = System.getDeviceSettings().screenWidth;

    var font = WatchUi.loadResource(Rez.Fonts.Tall);

    function initialize(params) {
        Drawable.initialize(params);
        // Here we just get parameters from the layout.xml file
        mIdleColor = params.get(:idleColor);
        mNormalColor = params.get(:normalColor);
        mMediumColor = params.get(:mediumColor);
        mDangerousColor = params.get(:dangerousColor);
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
        mArcType = params[:arcType];
        mDataDrawingDirection = params.get(:dataDrawingDirection);
        mDataSource = params.get(:dataSource);
        mDataSourceMaxValue = params.get(:dataSourceMaxValue);
    }
    function draw(dc) {
        // Rendering background arc
        dc.setColor(0x323232, 0x000000);
        dc.setPenWidth(mArcSize);
        dc.drawArc(
            mXCenterPosition,
            mYCenterPosition,
            mArcRadius,
            Graphics.ARC_CLOCKWISE,
            mStartDegree,
            mEndDegree
        );

        // Rendering foreground arc
        if(mDataSource >= mDataSourceMaxValue) {
            dc.setColor(mIdleColor, 0x000000);
            dc.drawArc(mXCenterPosition, mYCenterPosition, mArcRadius, Graphics.ARC_CLOCKWISE, mStartDegree, mEndDegree);
        } else {
            dc.setColor(mIdleColor, 0x000000);

            // Calculating position of the foreground 
            // About this part... Oh boy, don't even try to understand what is here,
            // because I just don't care about readability here, bc if it works - don't
            // touch it, and i have a spent a lot of nerves while trying to code this 
            // crap

            switch (mArcType) {
                case :speedArc: {
                    var degreeRange = mStartDegree.abs() + mEndDegree.abs();
                    var percentage = mDataSource.toFloat() / mDataSourceMaxValue.toFloat();
                    var preResult = degreeRange * percentage;
                    var result = mStartDegree - preResult;
                    dc.drawArc(mXCenterPosition, mYCenterPosition, mArcRadius, mArcDirection, mStartDegree, result);
                    break;
                }
                case :batteryArc: {
                    var degreeRange = mStartDegree - mEndDegree;
                    var percentage = mDataSource.toFloat() / mDataSourceMaxValue.toFloat();
                    var result = degreeRange - (degreeRange * percentage) + mEndDegree;
                    dc.drawArc(mXCenterPosition, mYCenterPosition, mArcRadius, mArcDirection, mStartDegree, result);
                    break;
                }
                case :temperatureArc: {
                    var degreeRange = mStartDegree.abs() + mEndDegree.abs();
                    var percentage = mDataSource.toFloat() / mDataSourceMaxValue.toFloat();
                    var preResult = degreeRange * percentage;
                    var result = preResult + mEndDegree;
                    dc.drawArc(mXCenterPosition, mYCenterPosition, mArcRadius, mArcDirection, mEndDegree, result);
                    break;
                }
            }
        }
    }

    function setValues(current, max) {
        mCurrent = current;
        mMaxValue = max;
    }
}