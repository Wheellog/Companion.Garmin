import Toybox.Application;
import Toybox.WatchUi;
import Toybox.Application.Storage;

class WheelLogCompanionApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
        Communications.registerForPhoneAppMessages(method(:phoneAppMessageHandler));

        // Initiating some runtime cache variables
        AppStorage.runtimeDb["comm_disconnectionCountdown"] = 4;
        AppStorage.runtimeDb["comm_lastResponseCode"] = 200;
        AppStorage.runtimeDb["wheel_lastConnectionState"] = false;
        AppStorage.runtimeDb["comm_wheelDisconnectionNoticeCountdown"] = 15;
        AppStorage.runtimeDb["comm_appDisconnectionNoticeCountdown"] = 15;
        AppStorage.runtimeDb["ui_donationNoticeCountdown"] = 10;
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
