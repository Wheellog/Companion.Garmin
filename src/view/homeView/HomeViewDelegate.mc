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
                    null,
                    "SpeedArcData",
                    AppStorage.getValue("ShowPwmInsteadOfSpeed"),
                    null
                )
            );
            var appThemeValue;
            if (AppStorage.getValue("AppTheme") == 0){
                appThemeValue = false;
            } else {
                appThemeValue = true;
            }
            var appThemSubLabel;
            if (AppStorage.getValue("AppTheme") == 0){
                appThemSubLabel = Rez.Strings.MainMenu_AppTheme_Light;
            } else {
                appThemSubLabel = Rez.Strings.MainMenu_AppTheme_Dark;
            }
            menu.addItem(
                new MenuItem(
                    Rez.Strings.MainMenu_AppTheme,
                    appThemSubLabel,
                    "AppTheme",
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
        var view = new DetailView(1);
        WatchUi.switchToView(view, new DetailViewDelegate(view), WatchUi.SLIDE_UP);
        return true;
    }

    function onPreviousPage() {
        var view = new DetailView(3);
        WatchUi.switchToView(view, new DetailViewDelegate(view), WatchUi.SLIDE_DOWN);
        return true;
    }
}