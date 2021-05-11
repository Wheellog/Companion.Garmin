using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Lang;
using Toybox.Communications;
using Toybox.System;
using Toybox.Attention;

module WheelData {
    var currentSpeed = "0.0",
        batteryPercentage = 0,
        batteryVoltage,
        temperature = 0,
        bluetooth,
        useMph,
        maxDialSpeed = 40,
        rideTime = "00:00:00",
        rideDistance,
        averageSpeed,
        topSpeed,
        power,
        pwm = "00",
        maxPwm = "00",
        alarmType;
        
    var webServerPort;
    var isAppConnected = false;

    function setIsAppConnected(data) {
        var previousState = WheelData.isAppConnected;
        WheelData.isAppConnected = data;

        if (WheelData.isAppConnected == true && previousState == false) {
            WatchUi.popView(WatchUi.SLIDE_DOWN);

            var method = new Lang.Method($, :dataUpdateTimerMethod);
            WheelData.dataUpdateTimer.start(method, 400, true); // Start a timer routine for constantly getting data from the phone
            DataServer.updateData("details"); // This is for filling base data, so there will be no "null"'s
        } else if (WheelData.isAppConnected == false) {
            var progressBar = new WatchUi.ProgressBar(WatchUi.loadResource(Rez.Strings.LoadingScreen_WaitingConnectionWithApp), null);
            WatchUi.pushView(progressBar, new WaitingForConnectionViewDelegate(), WatchUi.SLIDE_UP);
            if (WheelData.dataUpdateTimer == null) {
                WheelData.dataUpdateTimer.stop(); // Shut down timer
            }
        }
    }

    var dataUpdateTimer = new Timer.Timer();
    var appUpdateTimer = new Timer.Timer();
}

function dataUpdateTimerMethod() {
    DataServer.updateData_timer();
}

function appUpdateTimerMethod() {
    /*
     * Updating comm_disconnectionCountdown runtime variable
     */
    if(AppStorage.runtimeCache["comm_lastResponseCode"] != 200) {
        AppStorage.runtimeCache["comm_disconnectionCountdown"]--;
    } else {
        AppStorage.runtimeCache["comm_disconnectionCountdown"] = 4;
    }

    /*
     * And checking whether the comm_disconnectionCountdown is finished
     */
    if (AppStorage.runtimeCache["comm_disconnectionCountdown"] == 0) {
        WheelData.setIsAppConnected(false);
        Attention.playTone(ToneProfiles.disconnectionTone);
    }
}