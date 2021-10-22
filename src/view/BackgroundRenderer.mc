import Toybox.WatchUi;
import Toybox.System;

class BackgroundRenderer extends WatchUi.Drawable {
    function initialize(params) {
        Drawable.initialize(params);
    }

    function draw(dc) {
        if (AppStorage.getSetting("AppTheme") == 0) {
            dc.setColor(0xFFFFFF, 0x000000);
        } else {
            dc.setColor(0x000000, 0x000000);
        }
        dc.fillRectangle(0, 0, System.getDeviceSettings().screenWidth, System.getDeviceSettings().screenHeight);
    }
}