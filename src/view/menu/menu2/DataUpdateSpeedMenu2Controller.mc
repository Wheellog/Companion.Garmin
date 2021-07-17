import Toybox.WatchUi;
import Toybox.System;

class DataUpdateSpeedMenu2Controller extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "Fast": {
                AppStorage.setValue("DataUpdateSpeed", 400);
                break;
            }
            case "Medium": {
                AppStorage.setValue("DataUpdateSpeed", 1000);
                break;
            }
            case "Slow": {
                AppStorage.setValue("DataUpdateSpeed", 1500);
                break;
            }
            case "SuperSlow": {
                AppStorage.setValue("DataUpdateSpeed", 2000);
                break;
            }
        }
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
