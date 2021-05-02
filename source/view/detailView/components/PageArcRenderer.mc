using Toybox.WatchUi;
using Toybox.System;

class PageArcRenderer extends WatchUi.Drawable {
    var mArcColor, mArcWidth;
    function initialize(params) {
        Drawable.initialize(params);
        mArcColor = params[:arcColor];
        mArcWidth = params[:arcWidth];
    }

    function draw(dc) {
        dc.setColor(mArcColor, 0x000000);
        dc.setPenWidth(mArcWidth);

        // Here we calculate start and end degree for arc renderer

        var startDegree = ((180 / detailView_maxScreens) * (detailView_currentlyOnScreen - 1)) + 90;
        var endDegree = startDegree + (180 / detailView_maxScreens);

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