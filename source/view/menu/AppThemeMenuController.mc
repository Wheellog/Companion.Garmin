using Toybox.WatchUi;
using Toybox.System;

class AppThemeMenuController extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :LightTheme: {
                AppSettings.setValue(:appTheme, 0);
                break;
            }
            case :DarkTheme: {
                AppSettings.setValue(:appTheme, 1);
                break;
            }
        }
    }
}
