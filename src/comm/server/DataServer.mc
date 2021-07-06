using Toybox.Communications;
using Toybox.WatchUi;
using Toybox.Lang;

module DataServer {
    function updateData() {
        // Checking protocol type
        if (AppStorage.runtimeCache["comm_isNewProtocolAvailable"] == null) { // Checks whether it was checked if new communication protocol is available in WheelLog
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
            if (AppStorage.runtimeCache["comm_isNewProtocolAvailable"] == true) {
                Communications.makeWebRequest(
                    "http://127.0.0.1:" + WheelData.webServerPort + "/data",
                    null,
                    {
                        :method => Communications.HTTP_REQUEST_METHOD_GET,
                        :headers => {},
                        :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
                    },
                    new Lang.Method(DataServer, :updateUsingNewProtocol);
                );
            } else {
                Communications.makeWebRequest(
                    "http://127.0.0.1:" + WheelData.webServerPort + "/data",
                    null,
                    {
                        :method => Communications.HTTP_REQUEST_METHOD_GET,
                        :headers => {},
                        :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
                    },
                    new Lang.Method(DataServer, :updateUsingOldProtocol);
                );
            }
        }
    }
    
    function _protocolTypeCheckCallback(responseCode, data) {
        if (responseCode == 200) {
            AppStorage.runtimeCache["comm_isNewProtocolAvailable"] = true;
            AppStorage.runtimeCache["comm_protocolVersion"] = data;
        } else {
            AppStorage.runtimeCache["comm_isNewProtocolAvailable"] = true;
            AppStorage.runtimeCache["comm_protocolVersion"] = 2;
        }
    }

    function updateUsingNewProtocol(responseCode, data) {

    }

    function updateUsingOldProtocol(responseCode, data) {

    } 
}