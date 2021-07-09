using Toybox.WatchUi;
using Toybox.System;

class StartButtonActionMenuDelegate extends WatchUi.MenuInputDelegate {
    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onSelect(item) {
        switch (item) {
            case :Horn: {
                AppStorage.setValue("StartButtonAction", 0);
            }
            case :Lights: {
                AppStorage.setValue("StartButtonAction", 1);
            }
        }
    }
}
