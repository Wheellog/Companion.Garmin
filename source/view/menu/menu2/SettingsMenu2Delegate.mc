using Toybox.WatchUi;
using Toybox.System;

class SettingsMenu2Delegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item.getId()) {
            case "SpeedArcData": {
                if (AppSettings.getValue(:showPwmInsteadOfSpeed)) {
                    AppSettings.setValue(:showPwmInsteadOfSpeed, false);
                } else {
                    AppSettings.setValue(:showPwmInsteadOfSpeed, true);
                }
            }
        }
    }
}
