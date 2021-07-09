using Toybox.Attention;
using Toybox.Communications;
using Toybox.Lang;
using Toybox.Math;

function dataUpdateTimerMethod() {
    DataServer.updateData();
}

function appUpdateTimerMethod() {
    Alarms.alarmHandler();
    
    /*
     * Updating comm_disconnectionCountdown runtime variable
     */
    if(AppStorage.runtimeDb["comm_lastResponseCode"] != 200) {
        AppStorage.runtimeDb["comm_disconnectionCountdown"]--;
    } else {
        AppStorage.runtimeDb["comm_disconnectionCountdown"] = 10;
    }

    /*
     * And checking whether the comm_disconnectionCountdown is finished
     */
    if (AppStorage.runtimeDb["comm_disconnectionCountdown"] == 0) {
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
            AppStorage.runtimeDb["wheel_batteryLowToneCountdown"] = 30;
        }

        if (AppStorage.runtimeDb["wheel_batteryLowToneCountdown"] == 0) {
            Attention.playTone(ToneProfiles.wheelBatteryLowTone);
        }

        if (WheelData.isWheelConnected && AppStorage.runtimeDb["wheel_lastConnectionState"] == false && WheelData.isWheelConnected) {
            Attention.playTone(ToneProfiles.wheelConnectionTone);
            AppStorage.runtimeDb["wheel_lastConnectionState"] = WheelData.isWheelConnected;
        }

        if (WheelData.isWheelConnected && AppStorage.runtimeDb["wheel_lastConnectionState"] && WheelData.isWheelConnected == false) {
            Attention.playTone(ToneProfiles.wheelDisconnectionTone);
            AppStorage.runtimeDb["wheel_lastConnectionState"] = WheelData.isWheelConnected;
        }
    }

    if (AppStorage.runtimeDb["comm_wheelDisconnectionNoticeCountdown"] != 0 && WheelData.isWheelConnected == false) {
        AppStorage.runtimeDb["comm_wheelDisconnectionNoticeCountdown"]--;
    }

    if (AppStorage.runtimeDb["comm_wheelDisconnectionNoticeCountdown"] == 0 && WheelData.isWheelConnected == false) {
        AppStorage.runtimeDb["comm_wheelDisconnectionNoticeCountdown"] = 30;
        if (Attention has :playTone) { Attention.playTone(Attention.TONE_LOUD_BEEP); }
        if (Attention has :vibrate) { Attention.vibrate([ new Attention.VibeProfile(2000, 100), new Attention.VibeProfile(0, 100), new Attention.VibeProfile(2000, 1000) ]); }
    }

    if (AppStorage.runtimeDb["comm_appDisconnectionNoticeCountdown"] != 0 && WheelData.isWheelConnected == false) {
        AppStorage.runtimeDb["comm_appDisconnectionNoticeCountdown"]--;
    }

    if (AppStorage.runtimeDb["comm_appDisconnectionNoticeCountdown"] == 0 && WheelData.isWheelConnected == false) {
        AppStorage.runtimeDb["comm_appDisconnectionNoticeCountdown"] = 30;
        if (Math.rand() % 4 == 2 && AppStorage.runtimeDb["ui_donationNoticeCountdown"] != 0) { // Just randomly picking whether to display the donation message or not
            AppStorage.runtimeDb["ui_showDonationNotice"] = true;
        } else {
            AppStorage.runtimeDb["ui_showDonationNotice"] = false;
        }
        if (Attention has :playTone) { Attention.playTone(Attention.TONE_LOUD_BEEP); }
        if (Attention has :vibrate) { Attention.vibrate([ new Attention.VibeProfile(2000, 100), new Attention.VibeProfile(0, 100), new Attention.VibeProfile(2000, 1000) ]); }
    }

    if (AppStorage.runtimeDb["ui_donationNoticeCountdown"] > 0) {
        AppStorage.runtimeDb["ui_donationNoticeCountdown"]--;
    } else {
        AppStorage.runtimeDb["ui_donationNoticeCountdown"] = 10;
    }
}

function timerMethods_reconnectionAttemptResponse(responseCode, data) {
    if (responseCode == 200) {
        WheelData.setIsAppConnected(true);
    }
}