using Toybox.WatchUi;
using Toybox.System;

class HomeViewDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        if (Toybox.WatchUi has :Menu2) {
            var menu = new WatchUi.Menu2({
                :title => "Settings"
            });

            menu.addItem(
                new ToggleMenuItem(
                    "Show PWM on speed arc",
                    {
                        :enabled => "Enabled",
                        :disabled => "Disabled"
                    },
                    "SpeedArcData",
                    AppSettings.getValue(:showPwmInsteadOfSpeed),
                    null
                )
            );
            WatchUi.pushView(menu, new SettingsMenuTwoDelegate(), WatchUi.SLIDE_UP);
        } else {
            WatchUi.pushView(new Rez.Menus.SettingsMenu(), new SettingsMenuDelegate(), WatchUi.SLIDE_UP);
        }
        return true;
    }

    function onSelect() {
        Actions.triggerHorn();
    }

    function onNextPage() {
        WatchUi.switchToView(new DetailView(), new DetailViewDelegate(new DetailView()), WatchUi.SLIDE_UP);
        return true;
    }
}