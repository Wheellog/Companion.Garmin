using Toybox.WatchUi;
using Toybox.System;

class DataUpdateSpeedMenuController extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :Fast: {
                AppStorage.setValue("DataUpdateSpeed", 400);
                break;
            }
            case :Medium: {
                AppStorage.setValue("DataUpdateSpeed", 1000);
                break;
            }
            case :Slow: {
                AppStorage.setValue("DataUpdateSpeed", 1500);
                break;
            }
            case :SuperSlow: {
                AppStorage.setValue("DataUpdateSpeed", 2000);
                break;
            }
        }
    }
}
