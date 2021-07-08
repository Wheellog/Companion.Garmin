using Toybox.Communications;
using Toybox.WatchUi;

module Actions {
    var options = {
        :method => Communications.HTTP_REQUEST_METHOD_POST,
        :headers => {},
        :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
    };

    function triggerHorn(method) {
        switch (method) {
            case :ble: Communications.transmit("triggerHorn", null, null); break;
            case :web: Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/actions/triggerHorn", null, options, null); break;
        }
        WatchUi.requestUpdate();
    }

    function toggleFrontLight(method) {
        switch (method) {
            case :ble: Communications.transmit("toggleFrontLight", null, null); break;
            case :web: {
                WheelData.areLightsOn = !WheelData.areLightsOn;
                Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/actions/toggleFrontLight", null, options, null);
                break;
            }
        }
        WatchUi.requestUpdate();
    }
}