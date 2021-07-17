import Toybox.Communications;
import Toybox.WatchUi;
import Toybox.Lang;

module DataServer {
    function updateData() as Void {
        if (AppStorage.runtimeDb["comm_protocolVersion"] > 2) {
            Communications.makeWebRequest(
                "http://127.0.0.1:" + WheelData.webServerPort + "/data",
                null,
                {
                    :method => Communications.HTTP_REQUEST_METHOD_GET,
                    :headers => {},
                    :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
                },
                new Lang.Method($.DataServer, :updateimportNewProtocol)
            );
        } else {
            var options = {
                :method => Communications.HTTP_REQUEST_METHOD_GET,
                :headers => {},
                :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
            };

            // Update data about alarms
            Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/alarms", null, options, new Lang.Method(DataServer, :updateimportOldProtocol_alarms));

            // Update other data
            switch (AppStorage.runtimeDb["comm_dataSource"]) {
                case "home":
                    Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/main", null, options, new Lang.Method(DataServer, :updateimportOldProtocol_main));
                    break;
                case "details":
                    Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/details", null, options, new Lang.Method(DataServer, :updateimportOldProtocol_details));
                    break;
            }
        }
        WatchUi.requestUpdate();
    }

    function updateimportNewProtocol(responseCode as Lang.Number, data as Lang.Dictionary?) as Void {
        if (responseCode == 200) {
            switch (AppStorage.runtimeDb["comm_protocolVersion"]) {
                case 3: {                    
                    WheelData.batteryPercentageLoadDrop = data["percentageDropUnderLoad"];
                    WheelData.currentSpeed = data["speed"];
                    WheelData.speedLimit = data["speedLimit"];
                    WheelData.useMph = data["useMph"];
                    WheelData.batteryPercentage = data["battery"];
                    WheelData.temperature = data["temp"];
                    WheelData.pwm = data["pwm"];
                    WheelData.maxPwm = data["maxPwm"];
                    WheelData.isWheelConnected = data["isConnectedToWheel"];
                    WheelData.wheelModel = data["wheelModel"];
                    WheelData.averageSpeed = data["avgSpeed"];
                    WheelData.topSpeed = data["topSpeed"];
                    WheelData.batteryVoltage = data["voltage"];
                    WheelData.rideTime = data["ridingTime"];
                    WheelData.rideDistance = data["distance"];
                }
            }
            AppStorage.runtimeDb["comm_lastResponseCode"] = 200;
        } else {
            AppStorage.runtimeDb["comm_lastResponseCode"] = responseCode;
        }
    }

    function updateimportOldProtocol_main(responseCode as Lang.Number, data as Null or Lang.Dictionary) as Void {
        if (responseCode == 200) {
            parseOldProtocolData(:main, data);
            AppStorage.runtimeDb["comm_lastResponseCode"] = 200;
        } else {
            AppStorage.runtimeDb["comm_lastResponseCode"] = responseCode;
        }
    }

    function updateimportOldProtocol_details(responseCode, data) {
        if (responseCode == 200) {
            parseOldProtocolData(:details, data);
            AppStorage.runtimeDb["comm_lastResponseCode"] = 200;
        } else {
            AppStorage.runtimeDb["comm_lastResponseCode"] = responseCode;
        }
    }

    function updateimportOldProtocol_alarms(responseCode, data) {
        if (responseCode == 200) {
            parseOldProtocolData(:alarms, data);
            AppStorage.runtimeDb["comm_lastResponseCode"] = 200;
        } else {
            AppStorage.runtimeDb["comm_lastResponseCode"] = responseCode;
        }
    }

    function parseOldProtocolData(dataType, message) {
        switch (dataType) {
            case :main: {
                WheelData.currentSpeed = message["speed"];
                WheelData.topSpeed = message["topSpeed"];
                WheelData.speedLimit = message["speedLimit"];
                WheelData.useMph = message["useMph"];
                WheelData.batteryPercentage = message["battery"];
                WheelData.temperature = message["temp"];
                WheelData.pwm = message["pwm"];
                WheelData.maxPwm = message["maxPwm"];
                WheelData.isWheelConnected = message["connectedToWheel"];
                WheelData.wheelModel = message["wheelModel"];
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
                WheelData.isWheelConnected = message["connectedToWheel"];
                break;
            }
            case :alarms: {
                WheelData.alarmType = message.toNumber();
                Alarms.alarmHandler(WheelData.alarmType);
                break;
            }
        }
    }
}