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
    }
}