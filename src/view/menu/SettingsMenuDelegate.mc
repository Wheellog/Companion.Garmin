using Toybox.WatchUi;
using Toybox.System;

class SettingsMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case "AppTheme": {
                var menu = new WatchUi.Menu();
                menu.setTitle(Rez.Strings.MainMenu_AppTheme);
                menu.addItem(Rez.Strings.MainMenu_AppTheme_Light, "0");
                menu.addItem(Rez.Strings.MainMenu_AppTheme_Dark, "1");

                WatchUi.pushView(menu, new AppThemeMenuDelegate(), WatchUi.SLIDE_LEFT);
                break;
            }
            case "DataUpdateSpeed": {
                var menu = new WatchUi.Menu();
                menu.setTitle(Rez.Strings.MainMenu_DataUpdateSpeed);
                menu.addItem(Rez.Strings.MainMenu_DataUpdateSpeed_Fast, "400");
                menu.addItem(Rez.Strings.MainMenu_DataUpdateSpeed_Medium, "1000");
                menu.addItem(Rez.Strings.MainMenu_DataUpdateSpeed_Slow, "1500");
                menu.addItem(Rez.Strings.MainMenu_DataUpdateSpeed_SuperSlow, "2000");

                WatchUi.pushView(menu, new DataUpdateSpeedMenuDelegate(), WatchUi.SLIDE_LEFT);
                break;
            }
            case "StartButtonAction": {
                var menu = new WatchUi.Menu();
                menu.setTitle(Rez.Strings.MainMenu_StartButtonAction);
                menu.addItem(Rez.Strings.MainMenu_StartButtonAction_HornTrigger, "0");
                menu.addItem(Rez.Strings.MainMenu_StartButtonAction_FrontLightToggle, "1");

                WatchUi.pushView(menu, new StartButtonActionMenuDelegate(), WatchUi.SLIDE_LEFT);
                break;
            }
        }
    }
}
