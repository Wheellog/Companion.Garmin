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

            }
            case :details: {
                Communications.makeWebRequest("http://127.0.0.1" + webServerPort + "/data?type=details", null, options, method(:responseCallback));
            }
        }
    }

    function executeAction(action) {

    }

    function setPort(port) {
        webServerPort = port;
    }

    private function detailsResponseCallback(responseCode, data) {
        if (responseCode == 200) {
            
        }
    }
}