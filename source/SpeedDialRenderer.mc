using Toybox.WatchUi;

class SpeedDialRenderer extends WatchUi.Drawable {
    hidden var mIdleColor, mNormalColor, mMediumColor, mDangerousColor;
    function initialize(params) {
        Drawable.initialize(params);
        // Here we just get parameters from the layout.xml file
        mIdleColor = params.get(:idleColor);
        mNormalColor = params.get(:normalColor);
        mMediumColor = params.get(:mediumColor);
        mDangerousColor = params.get(:dangerousColor);
    }
    function draw(dc) {
        dc.drawArc(x, y, r, attr, degreeStart, degreeEnd);
    }
}