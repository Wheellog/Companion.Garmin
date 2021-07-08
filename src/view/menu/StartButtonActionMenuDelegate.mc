using Toybox.WatchUi;
using Toybox.System;

class StartButtonActionMenuDelegate extends WatchUi.MenuInputDelegate {
    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onSelect(item) {
        var number;
        if (item instanceof String) { number = item.toNumber(); } else { number = item.getId().toNumber(); }
        AppStorage.setValue("StartButtonAction", number);
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
