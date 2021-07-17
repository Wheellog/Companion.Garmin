import Toybox.WatchUi;
import Toybox.System;

class AppThemeMenuController extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :LightTheme: {
                AppStorage.setValue("AppTheme", 0);
                break;
            }
            case :DarkTheme: {
                AppStorage.setValue("AppTheme", 1);
                break;
            }
        }
    }
}
