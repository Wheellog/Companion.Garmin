using Toybox.WatchUi;
using Toybox.System;

class SpeedArcPwmConfirmationController extends WatchUi.ConfirmationDelegate {
    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response) {
        if (response == WatchUi.CONFIRM_NO) {
            AppStorage.setValue("ShowPwmInsteadOfSpeed", false);
        } else {
            AppStorage.setValue("ShowPwmInsteadOfSpeed", true);
        }
    }
}