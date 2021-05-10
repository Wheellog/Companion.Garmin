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
            WheelData.parseServerData(data, :main);
        }
    }


    function _detailsResponseCallback(responseCode, data) {        
        if (responseCode == 200) {
            WheelData.WheelData.parseServerData(data, :details);
        }
    }

    function _alarmsResponseCallback(responseCode, data) {
        if (responseCode == 200) {
            WheelData.parseServerData(data, :alarms);
        }
    }

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