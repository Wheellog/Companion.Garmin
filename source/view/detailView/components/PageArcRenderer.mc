using Toybox.WatchUi;
using Toybox.System;

class PageArcRenderer extends WatchUi.Drawable {
    var mArcColor;
    function initialize(params) {
        Drawable.initialize(params);
        mArcColor = params[:arcColor];
    }

    function draw(dc) {
        dc.setColor(mArcColor, 0x000000);
        dc.setPenWidth(15);
        var percentage = 1;
        if (detailView_currentlyOnScreen != 0) {
            percentage = detailView_maxScreens.toFloat() / detailView_currentlyOnScreen.toFloat();
        } 

        var startDegree, endDegree;

        var d = 180 * percentage;

        startDegree = 90 + d;

        endDegree = 270 - (d * detailView_maxScreens - 1);

        dc.drawArc(
            System.getDeviceSettings().screenWidth / 2,
            System.getDeviceSettings().screenHeight / 2,
            System.getDeviceSettings().screenWidth / 2,
            Graphics.ARC_COUNTER_CLOCKWISE,
            startDegree,
            endDegree
        );
    }
}