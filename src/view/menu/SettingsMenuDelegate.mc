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
                menu.addItem(Rez.Strings.MainMenu_AppTheme_Light, "Light");
                menu.addItem(Rez.Strings.MainMenu_AppTheme_Dark, "Dark");

                WatchUi.pushView(menu, new AppThemeMenuDelegate(), WatchUi.SLIDE_LEFT);
                break;
            }
            case "DataUpdateSpeed": {
                var menu = new WatchUi.Menu();
                menu.setTitle(Rez.Strings.MainMenu_DataUpdateSpeed);
                menu.addItem(Rez.Strings.MainMenu_DataUpdateSpeed_Fast, "Fast");
                menu.addItem(Rez.Strings.MainMenu_DataUpdateSpeed_Medium, "Medium");
                menu.addItem(Rez.Strings.MainMenu_DataUpdateSpeed_Slow, "Slow");
                menu.addItem(Rez.Strings.MainMenu_DataUpdateSpeed_SuperSlow, "SuperSLow");

                WatchUi.pushView(menu, new DataUpdateSpeedMenuDelegate(), WatchUi.SLIDE_LEFT);
                break;
            }
            case "StartButtonAction": {
                var menu = new WatchUi.Menu();
                menu.setTitle(Rez.Strings.MainMenu_StartButtonAction);
                menu.addItem(Rez.Strings.MainMenu_StartButtonAction_HornTrigger, "Horn");
                menu.addItem(Rez.Strings.MainMenu_StartButtonAction_FrontLightToggle, "Lights");

                WatchUi.pushView(menu, new StartButtonActionMenuDelegate(), WatchUi.SLIDE_LEFT);
                break;
            }
        }
    }
}
