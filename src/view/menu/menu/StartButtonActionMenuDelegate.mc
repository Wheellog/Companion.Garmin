import Toybox.WatchUi;
import Toybox.System;

class StartButtonActionMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        switch (item) {
            case :Horn: {
                AppStorage.setSetting("StartButtonAction", 0);
                break;
            }
            case :Lights: {
                AppStorage.setSetting("StartButtonAction", 1);
                break;
            }
        }
    }
}
