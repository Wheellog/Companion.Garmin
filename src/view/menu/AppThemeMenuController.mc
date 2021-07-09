using Toybox.WatchUi;
using Toybox.System;

class AppThemeMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        System.println(item);
        switch (item) {
            case :Dark: {
                AppStorage.setValue("AppTheme", 1);
            }
            case :Light: {
                AppStorage.setValue("AppTheme", 0);
            }
        }
    }
}
