using Toybox.WatchUi;
using Toybox.System;

class AppThemeMenuController extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :LightTheme: {
                AppStorage.setValue(:appTheme, 0);
                break;
            }
            case :DarkTheme: {
                AppStorage.setValue(:appTheme, 1);
                break;
            }
        }
    }
}
