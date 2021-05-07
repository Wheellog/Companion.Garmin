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
        rideTime = "",
        rideDistance,
        averageSpeed,
        topSpeed,
        power,
        pwm = "00",
        maxPwm = "00",
        alarmType;
        
    var webServerPort;
    var isAppConnected = false;

    var webDataSource;

    var dataUpdateTimer = new Timer.Timer();

    function parseServerData(message, dataType) {
        switch (dataType) {
            case :main: {
                currentSpeed = message["speed"];
                useMph = message["useMph"];
                batteryPercentage = message["battery"];
                temperature = message["temp"];
                pwm = message["pwm"];
                maxPwm = message["maxPwm"];
                break;
            }
            case :details: {
                useMph = message["useMph"];
                averageSpeed = message["avgSpeed"];
                topSpeed = message["topSpeed"];
                batteryVoltage = message["voltage"];
                batteryPercentage = message["battery"];
                rideTime = message["ridingTime"];
                rideDistance = message["distance"];
                pwm = message["pwm"];
                maxPwm = message["maxPwm"];
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

    if (WheelData.isAppConnected == true && previousState == false) {
        WatchUi.popView(WatchUi.SLIDE_DOWN);

        var method = new Lang.Method($, :WheelData_updateData2);
        WheelData.dataUpdateTimer.start(method, 400, true); // Start a timer routine for constantly getting data from the phone
        WheelData_updateData("details");
    } else if (WheelData.isAppConnected == false) {
        var progressBar = new WatchUi.ProgressBar(WatchUi.loadResource(Rez.Strings.LoadingScreen_WaitingConnectionWithApp), null);
        WatchUi.pushView(progressBar, new WaitingForConnectionViewDelegate(), WatchUi.SLIDE_UP);
        if (WheelData.dataUpdateTimer == null) {
            WheelData.dataUpdateTimer.stop(); // Shut down timer, bc it will malfunction if no server is up and running
        }
    }
}

function WheelData_updateData2() {
    WheelData_updateData(WheelData.webDataSource);
}

function WheelData_updateData(dataSource) {
    var options = {
        :method => Communications.HTTP_REQUEST_METHOD_GET,
        :headers => {},
        :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
    };

    var alarmMethod = new Lang.Method($, :WheelData_alarmsResponseCallback);

    // Always get data about alarms
    Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/alarms", null, options, alarmMethod);

    // And get only data needed
    switch (dataSource) {
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
    }
}

function WheelData_detailsResponseCallback(responseCode, data) {        
    if (responseCode == 200) {
        WheelData.WheelData.parseServerData(data, :details);
    }
}

function WheelData_alarmsResponseCallback(responseCode, data) {
    if (responseCode == 200) {
        WheelData.parseServerData(data, :alarms);
    }
}