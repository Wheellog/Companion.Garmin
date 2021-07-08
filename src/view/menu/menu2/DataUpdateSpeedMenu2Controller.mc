using Toybox.WatchUi;
using Toybox.System;

class DataUpdateSpeedMenu2Controller extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        AppStorage.setValue("DataUpdateSpeed", item.getId().toNumber());
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
