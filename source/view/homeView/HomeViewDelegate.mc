using Toybox.WatchUi;
using Toybox.System;

class HomeViewDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        if (Toybox.WatchUi has :Menu2) {
            var menu = new WatchUi.Menu2({
                :title => Rez.Strings.MainMenu_Title
            });

            menu.addItem(
                new ToggleMenuItem(
                    Rez.Strings.MainMenu_ShowPwmInsteadOfSpeed,
                    {
                        :enabled => Rez.Strings.Enabled,
                        :disabled => Rez.Strings.Disabled
                    },
                    "SpeedArcData",
                    AppSettings.getValue(:showPwmInsteadOfSpeed),
                    null
                )
            );
            var appThemeValue;
            if (AppSettings.getValue(:appTheme) == 0){
                appThemeValue = false;
            } else {
                appThemeValue = true;
            }
            menu.addItem(
                new ToggleMenuItem(
                    Rez.Strings.MainMenu_AppTheme,
                    {
                        :enabled => Rez.Strings.MainMenu_AppTheme_Dark,
                        :disabled => Rez.Strings.MainMenu_AppTheme_Light
                    },
                    "AppTheme",
                    appThemeValue,
                    null
                )
            );
            WatchUi.pushView(menu, new SettingsMenu2Delegate(), WatchUi.SLIDE_UP);
        } else {
            WatchUi.pushView(new Rez.Menus.SettingsMenu(), new SettingsMenuDelegate(), WatchUi.SLIDE_UP);
        }
        return true;
    }

    function onSelect() {
        Actions.triggerHorn(:web);
    }

    function onNextPage() {
        WatchUi.switchToView(new DetailView(), new DetailViewDelegate(new DetailView()), WatchUi.SLIDE_UP);
        return true;
    }
}