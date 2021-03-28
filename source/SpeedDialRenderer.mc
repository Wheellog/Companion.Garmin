using Toybox.WatchUi;

class SpeedDialRenderer extends WatchUi.Drawable {

    var mCurrent, mMaxValue;

    private var mIdleColor, mNormalColor, mMediumColor, mDangerousColor;

    private var screenCenterX = System.getDeviceSettings().screenWidth / 2;
    private var screenCenterY = System.getDeviceSettings().screenHeight / 2;

    private var screenHeight = System.getDeviceSettings().screenHeight;
    private var screenWidth = System.getDeviceSettings().screenWidth;

    function initialize(params) {
        Drawable.initialize(params);
        // Here we just get parameters from the layout.xml file
        mIdleColor = params.get(:idleColor);
        mNormalColor = params.get(:normalColor);
        mMediumColor = params.get(:mediumColor);
        mDangerousColor = params.get(:dangerousColor);
    }
    function draw(dc) {
        dc.setPenWidth(50);
        renderBackground(dc);
        var font = WatchUi.loadResource( Rez.Fonts.Tall );
        dc.setColor(0x3F8CFF, 0x000000);
        dc.drawArc(screenCenterX, screenCenterY, screenWidth / 2, Graphics.ARC_CLOCKWISE, -140, -30);

        dc.drawText(screenCenterX, screenCenterY, font, "22", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    function renderBackground(dc) {
        dc.setColor(0x323232, 0x000000);
        dc.drawArc(screenCenterX, screenCenterY, screenWidth / 2, Graphics.ARC_CLOCKWISE, -140, -40);
    }


    function setValues(current, max) {
        mCurrent = current;
        mMaxValue = max;
    }
}