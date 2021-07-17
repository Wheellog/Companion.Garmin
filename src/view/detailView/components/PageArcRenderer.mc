import Toybox.WatchUi;
import Toybox.System;

class PageArcRenderer extends WatchUi.Drawable {
    private var mArcColor, mArcWidth;
    private var indicatorSize;
    function initialize(params) {
        Drawable.initialize(params);
        mArcColor = params[:arcColor];
        mArcWidth = params[:arcWidth];

        if (indicatorSize == null) {
            indicatorSize = 180 / detailView_maxScreens;
        }
    }

    function draw(dc) {
        dc.setColor(mArcColor, 0x000000);
        dc.setPenWidth(mArcWidth);

        // Here we calculate start and end degree for arc renderer
        var startDegree = (indicatorSize * (detailView_currentlyOnScreen - 1)) + 90;
        var endDegree = startDegree + indicatorSize;

        dc.drawArc(
            System.getDeviceSettings().screenWidth / 2,
            System.getDeviceSettings().screenHeight / 2,
            System.getDeviceSettings().screenWidth / 2 - 6,
            Graphics.ARC_COUNTER_CLOCKWISE,
            startDegree,
            endDegree
        );
    }
}