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
                break;
            }
            case "AppTheme": {
                if (AppSettings.getValue(:appTheme) == 1) {
                    AppSettings.setValue(:appTheme, false);
                } else {
                    AppSettings.setValue(:appTheme, true);
                }
            }
        }
    }
}
