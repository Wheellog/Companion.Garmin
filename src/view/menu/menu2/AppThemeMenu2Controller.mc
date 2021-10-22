import Toybox.WatchUi;
import Toybox.System;

class AppThemeMenu2Controller extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "LightTheme": {
                AppStorage.setSetting("AppTheme", 0);
                break;
            }
            case "DarkTheme": {
                AppStorage.setSetting("AppTheme", 1);
                break;
            }
        }
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
