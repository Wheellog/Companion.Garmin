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
                Communications.makeWebRequest("http://127.0.0.1" + webServerPort + "/data?type=main", null, options, method(:detailsResponseCallback));
            }
            case :details: {
                Communications.makeWebRequest("http://127.0.0.1" + webServerPort + "/data?type=details", null, options, method(:detailsResponseCallback));
            }
        }
    }

    function executeAction(action) {

    }

    function setPort(port) {
        webServerPort = port;
    }
    private function mainResponseCallback(responseCode, data) {
        if (responseCode == 200) {
            parseData(data, :main);
        }
    }
    private function detailsResponseCallback(responseCode, data) {
        if (responseCode == 200) {
            parseData(data, :details);
        }
    }

    private function parseData(message, dataType) {
        var keyStore = WheelData.Constants.Data;

        switch (dataType) {
            case :main: {
                WheelData.CurrentSpeed = message[keyStore.CURRENT]
            }
            case :details: {

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
        //         WheelData.BottomSubtitleText = data[keyStore.BOTTOM_SUBTITLE];
        //     }
        // }
    }
}