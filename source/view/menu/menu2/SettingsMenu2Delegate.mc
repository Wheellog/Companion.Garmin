using Toybox.WatchUi;
using Toybox.System;

class SettingsMenu2Delegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "SpeedArcData": {
                if (AppStorage.getValue(:showPwmInsteadOfSpeed)) {
                    AppStorage.setValue(:showPwmInsteadOfSpeed, false);
                } else {
                    AppStorage.setValue(:showPwmInsteadOfSpeed, true);
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
        }
    }
}
