using Toybox.WatchUi;
using Toybox.System;

class SettingsMenu2Delegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "AppTheme": {
                var menu = new WatchUi.Menu2({
                    :title => Rez.Strings.MainMenu_AppTheme
                });

                menu.addItem(
                    new MenuItem(
                        Rez.Strings.MainMenu_AppTheme_Dark,
                        null,
                        "DarkTheme",
                        null
                    )
                );
                menu.addItem(
                    new MenuItem(
                        Rez.Strings.MainMenu_AppTheme_Light,
                        null,
                        "LightTheme",
                        null
                    )
                );
                WatchUi.pushView(menu, new AppThemeMenu2Controller(), WatchUi.SLIDE_LEFT);
                break;
            }
            case "DataUpdateSpeed": {
                var menu = new WatchUi.Menu2({
                    :title => Rez.Strings.MainMenu_DataUpdateSpeed
                });

                menu.addItem(
                    new MenuItem(
                        Rez.Strings.MainMenu_DataUpdateSpeed_Fast,
                        null,
                        "400",
                        null
                    )
                );
                menu.addItem(
                    new MenuItem(
                        Rez.Strings.MainMenu_DataUpdateSpeed_Medium,
                        null,
                        "1000",
                        null
                    )
                );
                menu.addItem(
                    new MenuItem(
                        Rez.Strings.MainMenu_DataUpdateSpeed_Slow,
                        null,
                        "1500",
                        null
                    )
                );
                menu.addItem(
                    new MenuItem(
                        Rez.Strings.MainMenu_DataUpdateSpeed_SuperSlow,
                        null,
                        "2000",
                        null
                    )
                );
                WatchUi.pushView(menu, new DataUpdateSpeedMenu2Controller(), WatchUi.SLIDE_LEFT);
            }
            case "StartButtonAction": {
                var menu = new WatchUi.Menu2({
                    :title => Rez.Strings.MainMenu_StartButtonAction
                });

                menu.addItem(new MenuItem(
                    Rez.Strings.MainMenu_StartButtonAction_HornTrigger,
                    null,
                    "0",
                    null
                ));

                menu.addItem(new MenuItem(
                    Rez.Strings.MainMenu_StartButtonAction_FrontLightToggle,
                    null,
                    "1",
                    null
                ));

                WatchUi.pushView(menu, new StartButtonActionMenu2Delegate(), WatchUi.SLIDE_LEFT);
            }
        }
    }
}
