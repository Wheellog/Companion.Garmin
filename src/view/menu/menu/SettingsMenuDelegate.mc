using Toybox.WatchUi;
using Toybox.System;

class SettingsMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :SpeedArcData: {
                WatchUi.pushView(
                    new WatchUi.Confirmation(
                        WatchUi.loadResource(Rez.Strings.MainMenu_ShowPwmInsteadOfSpeed_Title)
                    ),
                    new SpeedArcPwmConfirmationController(),
                    WatchUi.SLIDE_RIGHT);
                break;
            }
            case :AppTheme: {
                WatchUi.pushView(new Rez.Menus.AppThemeMenu(), new AppThemeMenuController(), WatchUi.SLIDE_LEFT);
                break;
            }
        }
    }
}
