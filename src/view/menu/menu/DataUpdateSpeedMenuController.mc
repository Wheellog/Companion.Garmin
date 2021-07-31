import Toybox.WatchUi;
import Toybox.System;

class DataUpdateSpeedMenuController extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :Fast: {
                AppStorage.setSetting("DataUpdateSpeed", 400);
                break;
            }
            case :Medium: {
                AppStorage.setSetting("DataUpdateSpeed", 1000);
                break;
            }
            case :Slow: {
                AppStorage.setSetting("DataUpdateSpeed", 1500);
                break;
            }
            case :SuperSlow: {
                AppStorage.setSetting("DataUpdateSpeed", 2000);
                break;
            }
        }
    }
}
