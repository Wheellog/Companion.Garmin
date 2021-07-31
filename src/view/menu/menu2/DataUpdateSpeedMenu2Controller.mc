import Toybox.WatchUi;
import Toybox.System;

class DataUpdateSpeedMenu2Controller extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "Fast": {
                AppStorage.setSetting("DataUpdateSpeed", 400);
                break;
            }
            case "Medium": {
                AppStorage.setSetting("DataUpdateSpeed", 1000);
                break;
            }
            case "Slow": {
                AppStorage.setSetting("DataUpdateSpeed", 1500);
                break;
            }
            case "SuperSlow": {
                AppStorage.setSetting("DataUpdateSpeed", 2000);
                break;
            }
        }
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
