using Toybox.WatchUi;
using Toybox.System;

class AppThemeMenu2Controller extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "LightTheme": {
                AppSettings.setValue(:appTheme, 0);
                WatchUi.popView(WatchUi.SLIDE_RIGHT);
                break;
            }
            case "DarkTheme": {
                AppSettings.setValue(:appTheme, 1);
                WatchUi.popView(WatchUi.SLIDE_RIGHT);
                break;
            }
        }
    }
}