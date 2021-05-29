using Toybox.WatchUi;
using Toybox.System;

class DataUpdateSpeedMenu2Controller extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "Fast": {
                AppStorage.setValue("DataUpdateSpeed", 400);
                WatchUi.popView(WatchUi.SLIDE_RIGHT);
                break;
            }
            case "Medium": {
                AppStorage.setValue("DataUpdateSpeed", 1000);
                WatchUi.popView(WatchUi.SLIDE_RIGHT);
                break;
            }
            case "Slow": {
                AppStorage.setValue("DataUpdateSpeed", 1500);
                WatchUi.popView(WatchUi.SLIDE_RIGHT);
                break;
            }
            case "SuperSlow": {
                AppStorage.setValue("DataUpdateSpeed", 2000);
                WatchUi.popView(WatchUi.SLIDE_RIGHT);
                break;
            }
        }
    }
}
