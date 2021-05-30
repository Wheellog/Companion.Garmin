using Toybox.WatchUi;
using Toybox.System;

class SettingsMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :AppTheme: {
                WatchUi.pushView(new Rez.Menus.AppThemeMenu(), new AppThemeMenuController(), WatchUi.SLIDE_LEFT);
                break;
            }
            case :DataUpdateSpeed: {
                WatchUi.pushView(new Rez.Menus.UpdateSpeed(), new DataUpdateSpeedMenuController(), WatchUi.SLIDE_LEFT);
                break;
            }
        }
    }
}
