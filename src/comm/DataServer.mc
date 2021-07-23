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

    function updateimportNewProtocol(responseCode as Lang.Number, data as Lang.Array?) as Void {
        if (responseCode == 200) {
            switch (AppStorage.runtimeDb["comm_protocolVersion"]) {
                case 3: {
                    WheelData.batteryPercentageLoadDrop = data[0];
                    WheelData.currentSpeed = data[1];
                    WheelData.speedLimit = data[2];
                    WheelData.useMph = data[3];
                    WheelData.batteryPercentage = data[4];
                    WheelData.temperature = data[5];
                    WheelData.pwm = data[6];
                    WheelData.maxPwm = data[7];
                    WheelData.isWheelConnected = data[8];
                    WheelData.wheelModel = data[9];
                    WheelData.averageSpeed = data[10];
                    WheelData.topSpeed = data[11];
                    WheelData.batteryVoltage = data[12];
                    WheelData.rideTime = data[13];
                    WheelData.rideDistance = data[14];
                }
            }
        }
        AppStorage.runtimeDb["comm_lastResponseCode"] = responseCode;
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