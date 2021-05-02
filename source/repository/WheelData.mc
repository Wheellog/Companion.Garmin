using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Lang;
using Toybox.Communications;
using Toybox.System;

module WheelData {
    var currentSpeed = "0.0",
        batteryPercentage = 0,
        batteryVoltage,
        temperature = 0,
        bluetooth,
        useMph,
        maxDialSpeed = 40,
        rideTime,
        rideDistance,
        averageSpeed,
        topSpeed,
        power,
        pwm,
        maxPwm,
        alarmType,
        bottomSubtitle = "";

    var webServerPort;
    var isAppConnected = false;

    var webDataSource;

    var dataUpdateTimer = new Timer.Timer();

    function parseServerData(message, dataType) {
        switch (dataType) {
            case :main: {
                WheelData.currentSpeed = message["0"];
                WheelData.useMph = message["1"];
                WheelData.batteryPercentage = message["2"];
                WheelData.temperature = message["3"];
                WheelData.bottomSubtitle = message["4"];
                break;
            }
            case :details: {
                WheelData.useMph = message["0"];
                WheelData.averageSpeed = message["1"];
                WheelData.topSpeed = message["2"];
                WheelData.batteryVoltage = message["3"];
                WheelData.batteryPercentage = message["4"];
                WheelData.rideTime = message["5"];
                WheelData.rideDistance = message["6"];
                break;
            }
            case :alarms: {
                WheelData.alarmType = message.toNumber();
                Alarms.alarmHandler();
                break;
            }
        }
    }
}

function setIsAppConnected(data) {
        var previousState = WheelData.isAppConnected;
        WheelData.isAppConnected = data;

        if (WheelData.isAppConnected == true) {
            WatchUi.popView(WatchUi.SLIDE_DOWN);

            var method = new Lang.Method($, :WheelData_updateData);
            WheelData.dataUpdateTimer.start(method, 400, true); // Start a timer routine for constantly getting data from the phone
        } else if (WheelData.isAppConnected == false) {
            var progressBar = new WatchUi.ProgressBar(WatchUi.loadResource(Rez.Strings.LoadingScreen_WaitingConnectionWithApp), null);
            WatchUi.pushView(progressBar, new WaitingForConnectionViewDelegate(), WatchUi.SLIDE_UP);
            if (WheelData.dataUpdateTimer == null) {
                WheelData.dataUpdateTimer.stop(); // Shut down timer, bc it will malfunction if no server is up and running
            }
        }
    }

function WheelData_updateData() {
    var options = {
        :method => Communications.HTTP_REQUEST_METHOD_GET,
        :headers => {},
        :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
    };

    var alarmMethod = new Lang.Method($, :WheelData_alarmsResponseCallback);

    // Always get data about alarms
    Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/alarms", null, options, alarmMethod);

    // And get only data needed
    switch (WheelData.webDataSource) {
        case "home":
            var mainMethod = new Lang.Method($, :WheelData_mainResponseCallback);
            Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/main", null, options, mainMethod);
            break;
        case "details":
            var detailsMethod = new Lang.Method($, :WheelData_detailsResponseCallback);
            Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/details", null, options, detailsMethod);
            break;
    }
    WatchUi.requestUpdate();
}

function WheelData_mainResponseCallback(responseCode, data) {
    if (responseCode == 200) {
        WheelData.parseServerData(data, :main);
    } else {
        WheelData.bottomSubtitle = "Failed";
    }
}

function WheelData_detailsResponseCallback(responseCode, data) {        
    if (responseCode == 200) {
        WheelData.WheelData.parseServerData(data, :details);
    } else {
        WheelData.bottomSubtitle = "Failed";
    }
}

function WheelData_alarmsResponseCallback(responseCode, data) {
    if (responseCode == 200) {
        WheelData.parseServerData(data, :alarms);
    } else {
        WheelData.bottomSubtitle = "Failed";
    }
}