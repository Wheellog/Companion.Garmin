using Toybox.Communications;
using Toybox.System;

class WebServer {
    var webServerPort;

    // Constructor
    function initialize(port) {
        webServerPort = port;
    }

    function updateData(dataType) {
        var options = {
			:method => Communications.HTTP_REQUEST_METHOD_GET,
			:headers => {},
			:responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
		};
        switch (dataType) {
            case :main: {
                var requestPath = "http://127.0.0.1:" + webServerPort + "/data?type=main";
                Communications.makeWebRequest(requestPath, null, options, method(:detailsResponseCallback));
            }
            case :details: {
                var requestPath = "http://127.0.0.1:" + webServerPort + "/data?type=details";
                Communications.makeWebRequest(requestPath, null, options, method(:detailsResponseCallback));
            }
            case :alarms: {
                var requestPath = "http://127.0.0.1:" + webServerPort + "/data?type=alarms";
                Communications.makeWebRequest(requestPath, null, options, method(:detailsResponseCallback));
            }
        }
    }

    function executeAction(action) {
         var options = {
			:method => Communications.HTTP_REQUEST_METHOD_POST,
			:headers => {},
			:responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
		};
        switch (action) {
            case "triggerHorn": {
                var requestPath = "http://127.0.0.1:" + webServerPort + "/actions/triggerHorn";
                Communications.makeWebRequest(requestPath, null, options, null);
            }
        }
    }

    function setPort(port) {
        webServerPort = port;
    }

    function mainResponseCallback(responseCode, data) {
        if (responseCode == 200) {
            parseData(data, :main);
        } 
    }

    function detailsResponseCallback(responseCode, data) {        
        if (responseCode == 200) {
            parseData(data, :details);
        }
    }

    function parseData(message, dataType) {
        switch (dataType) {
            case :main: {
                WheelData.currentSpeed = message[0];
                WheelData.useMph = message[1];
                WheelData.batteryPercentage = message[2];
                WheelData.temperature = message[3];
                WheelData.bottomSubtitle = message[4];
                break;
            }
            case :details: {
                WheelData.useMph = message[0];
                WheelData.averageSpeed = message[1];
                WheelData.topSpeed = message[2];
                WheelData.batteryVoltage = message[3];
                WheelData.batteryPercentage = message[4];
                WheelData.rideTime = message[5];
                WheelData.rideDistance = message[6];
                break;
            }
            case :alarms: {
                WheelData.alarmType = message;
                break;
            }
        }
        
        // switch (type) {
        //     case constantsStore.MessageType.EUC_DATA: {
        //         // Here we will parse data from WheelLog and put it into respectable variables
        //         var keyStore = constantsStore.MailKeys.Data;
                
        //         WheelData.CurrentSpeed = data[keyStore.CURRENT_SPEED];
        //         WheelData.BatteryPercentage = data[keyStore.BATTERY_PERCENTAGE];
        //         WheelData.BatteryVoltage = (data[keyStore.BATTERY_VOLTAGE] / 10).toFloat() / 10.toFloat();
        //         WheelData.Temperature = data[keyStore.TEMPERATURE];
        //         WheelData.Bluetooth = data[keyStore.BT_STATE];
        //         WheelData.RideTime = data[keyStore.RIDE_TIME];
        //         WheelData.RideDistance = data[keyStore.RIDE_DISTANCE];
        //         WheelData.AverageSpeed = (data[keyStore.AVG_SPEED] / 100000).toNumber(); // Here we convert the avg speed number from for e.g. 29.475000 to 29.5
        //         WheelData.TopSpeed = (data[keyStore.TOP_SPEED] / 10).toFloat() / 10.toFloat();
        //         WheelData.Power = data[keyStore.POWER];
        //         WheelData.Pwm = data[keyStore.PWM];
        //         WheelData.AlarmType = data[keyStore.ALARM_TYPE];
        //         WheelData.bottomSubtitle = data[keyStore.BOTTOM_SUBTITLE];
        //     }
        // }
    }
}