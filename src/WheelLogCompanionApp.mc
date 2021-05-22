using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Application.Storage;

class WheelLogCompanionApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
        Communications.registerForPhoneAppMessages(method(:phoneAppMessageHandler));

        // Initiating some runtime cache variables
        AppStorage.runtimeCache["comm_disconnectionCountdown"] = 4;
        AppStorage.runtimeCache["comm_lastResponseCode"] = 200;
        AppStorage.runtimeCache["wheel_lastConnectionState"] = false;
        WheelData.appUpdateTimer.start(method(:appUpdateTimerMethod), 500, true);
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new HomeView(), new HomeViewDelegate(), WatchUi.SLIDE_LEFT ];
    }
}
