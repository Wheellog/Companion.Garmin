using Toybox.Communications;
using Toybox.WatchUi;
using Toybox.Lang;

module DataServer {
    function updateData() {
        // Checking protocol type
        if (AppStorage.runtimeDb["comm_isNewProtocolAvailable"] == null) { // Checks whether it was checked if new communication protocol is available in WheelLog
            Communications.makeWebRequest(
                "http://127.0.0.1:" + WheelData.webServerPort + "/newProtocolAvailable",
                null,
                {
                    :method => Communications.HTTP_REQUEST_METHOD_GET,
                    :headers => {},
                    :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
                },
                new Lang.Method(DataServer, :_protocolTypeCheckCallback)
            );
        } else {
            if (AppStorage.runtimeDb["comm_isNewProtocolAvailable"] == true) {
                Communications.makeWebRequest(
                    "http://127.0.0.1:" + WheelData.webServerPort + "/data",
                    null,
                    {
                        :method => Communications.HTTP_REQUEST_METHOD_GET,
                        :headers => {},
                        :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
                    },
                    new Lang.Method(DataServer, :updateUsingNewProtocol)
                );
            } else {
                var options = {
                    :method => Communications.HTTP_REQUEST_METHOD_GET,
                    :headers => {},
                    :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
                };

                // Update data about alarms
                Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/alarms", null, options, new Lang.Method(DataServer, :updateUsingOldProtocol_alarms));

                // Update other data
                switch (AppStorage.runtimeDb["comm_dataSource"]) {
                    case "home":
                        Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/main", null, options, new Lang.Method(DataServer, :updateUsingOldProtocol_main));
                        break;
                    case "details":
                        Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/data/details", null, options, new Lang.Method(DataServer, :updateUsingOldProtocol_details));
                        break;
                }
            }
        }
        WatchUi.requestUpdate();
    }
    
    function _protocolTypeCheckCallback(responseCode, data) {
        if (responseCode == 200) {
            AppStorage.runtimeDb["comm_isNewProtocolAvailable"] = true;
            AppStorage.runtimeDb["comm_protocolVersion"] = data;
        } else {
            AppStorage.runtimeDb["comm_isNewProtocolAvailable"] = false;
            AppStorage.runtimeDb["comm_protocolVersion"] = 2;
        }
    }

    function updateUsingNewProtocol(responseCode, data) {
        switch (data["headers"]["protocolVersion"]) {
            case 3: {
                AppStorage.runtimeDb["comm_unsupportedProtocolVersionDetected"] = false;
                
                WheelData.batteryPercentageLoadDrop = data["percentageLoadDrop"];
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
                WheelData.alarmType = data["additional"]["alarmType"];
                WheelData.areLightsOn = data["additional"]["areLightsOn"];
            }
            default: {
                AppStorage.runtimeDb["comm_unsupportedProtocolVersionDetected"] = true;
            }
        }
    }

    function updateUsingOldProtocol_main(responseCode, data) {
        if (responseCode == 200) {
            parseOldProtocolData(:main, data);
            AppStorage.runtimeDb["comm_lastResponseCode"] = 200;
        } else {
            AppStorage.runtimeDb["comm_lastResponseCode"] = responseCode;
        }
    }

    function updateUsingOldProtocol_details(responseCode, data) {
        if (responseCode == 200) {
            parseOldProtocolData(:details, data);
            AppStorage.runtimeDb["comm_lastResponseCode"] = 200;
        } else {
            AppStorage.runtimeDb["comm_lastResponseCode"] = responseCode;
        }
    }

    function updateUsingOldProtocol_alarms(responseCode, data) {
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
                Alarms.alarmHandler();
                break;
            }
        }
    }
}