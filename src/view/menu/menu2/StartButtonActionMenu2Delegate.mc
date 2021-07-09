using Toybox.WatchUi;
using Toybox.System;

class StartButtonActionMenu2Delegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "TriggerHorn": {
                AppStorage.setValue("StartButtonAction", 0);
                break;
            }
            case "ToggleFrontLights": {
                AppStorage.setValue("StartButtonAction", 1);
                break;
            }
        }
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
