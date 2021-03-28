using Toybox.WatchUi;

class SpeedDialRenderer extends WatchUi.Drawable {

    private var mIdleColor, mNormalColor, mMediumColor, mDangerousColor;

    function initialize(params) {
        Drawable.initialize(params);
        // Here we just get parameters from the layout.xml file
        mIdleColor = params.get(:idleColor);
        mNormalColor = params.get(:normalColor);
        mMediumColor = params.get(:mediumColor);
        mDangerousColor = params.get(:dangerousColor);
    }
    function draw(dc) {
        dc.setColor(0x3F8CFF, 0x000000);
        dc.setPenWidth(70);
        dc.drawArc(System.getDeviceSettings().screenWidth / 2, System.getDeviceSettings().screenHeight / 2, 120, Graphics.ARC_CLOCKWISE, -140, -40);
    }
}