import Toybox.WatchUi;
import Toybox.System;

class StartButtonActionMenu2Delegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "TriggerHorn": {
                AppStorage.setSetting("StartButtonAction", 0);
                break;
            }
            case "ToggleFrontLights": {
                AppStorage.setSetting("StartButtonAction", 1);
                break;
            }
        }
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
