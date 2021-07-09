using Toybox.WatchUi;
using Toybox.System;

class StartButtonActionMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :Horn: {
                AppStorage.setValue("StartButtonAction", 0);
                break;
            }
            case :Lights: {
                AppStorage.setValue("StartButtonAction", 1);
                break;
            }
        }
    }
}
