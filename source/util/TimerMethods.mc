using Toybox.Attention;

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
        Attention.playTone(ToneProfiles.appDisconnectionTone);
    }

    if (WheelData.batteryPercentage < 20 && WheelData.isWheelConnected) {
        AppStorage.runtimeCache["wheel_batteryLowToneCountdown"] = 30;
    }

    if (AppStorage.runtimeCache["wheel_batteryLowToneCountdown"] == 0) {
        Attention.playTone(ToneProfiles.wheelBatteryLowTone);
    }

    // if (WheelData.isWheelConnected && AppStorage.runtimeCache["wheel_lastConnectionState"] == false && WheelData.isAppConnected) {
    //     Attention.playTone(ToneProfiles.wheelConnectionTone);
    //     AppStorage.runtimeCache["wheel_lastConnectionState"] == WheelData.isWheelConnected;
    // }
}
