using Toybox.Attention;
using Toybox.Communications;
using Toybox.Lang;

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
        AppStorage.runtimeCache["comm_disconnectionCountdown"] = 10;
    }

    /*
     * And checking whether the comm_disconnectionCountdown is finished
     */
    if (AppStorage.runtimeCache["comm_disconnectionCountdown"] == 0) {
        WheelData.setIsAppConnected(false);
        if (Attention has :playTone) {
            Attention.playTone(ToneProfiles.appDisconnectionTone);
        }
    }

    if (WheelData.isAppConnected == false) {
        Communications.makeWebRequest(
            "http://127.0.0.1:" + WheelData.webServerPort + "/data/alarms",
            null,
            {
                :method => Communications.HTTP_REQUEST_METHOD_GET,
                :headers => {},
                :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
            },
            new Lang.Method($, :timerMethods_reconnectionAttemptResponse)
        );
    }

    if (Attention has :playTone) {
        if (WheelData.batteryPercentage < 20 && WheelData.isWheelConnected) {
            AppStorage.runtimeCache["wheel_batteryLowToneCountdown"] = 30;
        }

        if (AppStorage.runtimeCache["wheel_batteryLowToneCountdown"] == 0) {
            Attention.playTone(ToneProfiles.wheelBatteryLowTone);
        }

        if (WheelData.isWheelConnected && AppStorage.runtimeCache["wheel_lastConnectionState"] == false && WheelData.isWheelConnected) {
            Attention.playTone(ToneProfiles.wheelConnectionTone);
            AppStorage.runtimeCache["wheel_lastConnectionState"] = WheelData.isWheelConnected;
        }

        if (WheelData.isWheelConnected && AppStorage.runtimeCache["wheel_lastConnectionState"] && WheelData.isWheelConnected == false) {
            Attention.playTone(ToneProfiles.wheelDisconnectionTone);
            AppStorage.runtimeCache["wheel_lastConnectionState"] = WheelData.isWheelConnected;
        }
    }
}

function timerMethods_reconnectionAttemptResponse(responseCode, data) {
    if (responseCode == 200) {
        WheelData.setIsAppConnected(true);
    }
}