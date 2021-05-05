using Toybox.WatchUi;
using Toybox.System;

class SettingsMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :SpeedArcData: {
                WatchUi.pushView(new WatchUi.Confirmation("Enabled"), new SpeedArcPwmConfirmationController(), WatchUi.SLIDE_UP);
            }
            case :AppTheme: {
                WatchUi.pushView(new Rez.Menus.AppThemeMenu(), new AppThemeMenuController(), WatchUi.SLIDE_UP);
            }
        }
    }
}
