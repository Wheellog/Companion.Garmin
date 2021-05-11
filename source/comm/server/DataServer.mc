using Toybox.Communications;
using Toybox.WatchUi;
using Toybox.Lang;

module DataServer {
    function updateData_timer() {
        updateData(AppStorage.runtimeCache["comm_dataSource"]);
    }

    function updateData(dataSource) {
        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_GET,
            :headers => {},
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
        };

        var alarmMethod = new Lang.Method(DataServer, :_alarmsResponseCallback);

        // Always get data about alarms
        Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/alarms", null, options, alarmMethod);

        // And get only data needed
        switch (dataSource) {
            case "home":
                var mainMethod = new Lang.Method(DataServer, :_mainResponseCallback);
                Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/main", null, options, mainMethod);
                break;
            case "details":
                var detailsMethod = new Lang.Method(DataServer, :_detailsResponseCallback);
                Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/details", null, options, detailsMethod);
                break;
        }
        WatchUi.requestUpdate();
    }

    function _mainResponseCallback(responseCode, data) {
        if (responseCode == 200) {
            parseServerData(data, :main);
            AppStorage.runtimeCache["comm_lastResponseCode"] = 200;
        } else {
            AppStorage.runtimeCache["comm_lastResponseCode"] = responseCode;
        }
    }


    function _detailsResponseCallback(responseCode, data) {        
        if (responseCode == 200) {
            parseServerData(data, :details);
            AppStorage.runtimeCache["comm_lastResponseCode"] = 200;
        } else {
            AppStorage.runtimeCache["comm_lastResponseCode"] = responseCode;
        }
    }

    function _alarmsResponseCallback(responseCode, data) {
        if (responseCode == 200) {
            parseServerData(data, :alarms);
            AppStorage.runtimeCache["comm_lastResponseCode"] = 200;
        } else {
            AppStorage.runtimeCache["comm_lastResponseCode"] = responseCode;
        }
    }

    function parseServerData(message, dataType) {
        switch (dataType) {
            case :main: {
                WheelData.currentSpeed = message["speed"];
                WheelData.useMph = message["useMph"];
                WheelData.batteryPercentage = message["battery"];
                WheelData.temperature = message["temp"];
                WheelData.pwm = message["pwm"];
                WheelData.maxPwm = message["maxPwm"];
                break;
            }
            case :details: {
                WheelData.useMph = message["useMph"];
                WheelData.averageSpeed = message["avgSpeed"];
                WheelData.topSpeed = message["topSpeed"];
                WheelData.batteryVoltage = message["voltage"];
                WheelData.batteryPercentage = message["battery"];
                WheelData.rideTime = message["ridingTime"];
                WheelData.rideDistance = message["distance"];
                WheelData.pwm = message["pwm"];
                WheelData.maxPwm = message["maxPwm"];
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