using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application.Properties;
using Toybox.Application.Storage;

class WheelLogGarminMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :showVoltageInsteadOfPercentage:
                var newValue = !Storage.getValue("showVoltageInsteadOfPercentage");
                Properties.setValue("showVoltageInsteadOfPercentage", newValue);
                WatchUi.requestUpdate();
                break;
        }
    }

}