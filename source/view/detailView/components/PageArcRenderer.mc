using Toybox.WatchUi;
using Toybox.System;

class PageArcRenderer extends WatchUi.Drawable {
    var mArcColor, mArcWidth;
    function initialize(params) {
        Drawable.initialize(params);
        mArcColor = params[:arcColor];
        mArcWidth = params[:arcWidth];

        if (AppStorage.readFromRuntimeCache("detailView_indicatorSize") == null) {
            AppStorage.writeToRuntimeCache("detailView_indicatorSize", 180 / detailView_maxScreens);
        }
    }

    function draw(dc) {
        dc.setColor(mArcColor, 0x000000);
        dc.setPenWidth(mArcWidth);

        // Here we calculate start and end degree for arc renderer
        var startDegree = (AppStorage.readFromRuntimeCache("detailView_indicatorSize") - AppStorage.readFromRuntimeCache("detailView_indicatorSize") * detailView_currentlyOnScreen) + 90;
        var endDegree = startDegree - AppStorage.readFromRuntimeCache("detailView_indicatorSize");

        dc.drawArc(
            System.getDeviceSettings().screenWidth / 2,
            System.getDeviceSettings().screenHeight / 2,
            System.getDeviceSettings().screenWidth / 2,
            Graphics.ARC_CLOCKWISE,
            startDegree,
            endDegree
        );
    }
}