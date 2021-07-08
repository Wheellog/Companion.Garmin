using Toybox.WatchUi;
using Toybox.System;

class StartButtonActionMenu2Delegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        AppStorage.setValue("StartButtonAction", item.getId().toNumber());
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
