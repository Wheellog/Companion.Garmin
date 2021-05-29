using Toybox.WatchUi;
using Toybox.System;

class SettingsMenu2Delegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "SpeedArcData": {
                if (AppStorage.getValue("ShowPwmInsteadOfSpeed")) {
                    AppStorage.setValue("ShowPwmInsteadOfSpeed", false);
                } else {
                    AppStorage.setValue("ShowPwmInsteadOfSpeed", true);
                }
                break;
            }
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
                        "Fast",
                        null
                    )
                );
                menu.addItem(
                    new MenuItem(
                        Rez.Strings.MainMenu_DataUpdateSpeed_Medium,
                        null,
                        "Medium",
                        null
                    )
                );
                menu.addItem(
                    new MenuItem(
                        Rez.Strings.MainMenu_DataUpdateSpeed_Slow,
                        null,
                        "Slow",
                        null
                    )
                );
                menu.addItem(
                    new MenuItem(
                        Rez.Strings.MainMenu_DataUpdateSpeed_SuperSlow,
                        null,
                        "SuperSlow",
                        null
                    )
                );
                WatchUi.pushView(menu, new DataUpdateSpeedMenu2Controller(), WatchUi.SLIDE_LEFT);
            }
        }
    }
}
