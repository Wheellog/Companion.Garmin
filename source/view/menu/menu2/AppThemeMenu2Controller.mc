using Toybox.WatchUi;
using Toybox.System;

class AppThemeMenu2Controller extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "LightTheme": {
                AppStorage.setValue(:appTheme, 0);
                WatchUi.popView(WatchUi.SLIDE_RIGHT);
                break;
            }
            case "DarkTheme": {
                AppStorage.setValue(:appTheme, 1);
                WatchUi.popView(WatchUi.SLIDE_RIGHT);
                break;
            }
        }
    }
}
