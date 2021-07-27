import Toybox.Communications;
import Toybox.WatchUi;

module Actions {
    var options = {
        :method => Communications.HTTP_REQUEST_METHOD_POST,
        :headers => {},
        :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
    };

    function triggerHorn(method) {
        switch (method) {
            case :ble: Communications.transmit("triggerHorn", null, new ActionConnectionListener()); break;
            case :web: Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/actions/triggerHorn", null, options, null); break;
        }
        WatchUi.requestUpdate();
    }

    function toggleFrontLight(method) {
        switch (method) {
            case :ble: Communications.transmit("toggleFrontLight", null, new ActionConnectionListener()); break;
            case :web: {
                WheelData.areLightsOn = !WheelData.areLightsOn;
                Communications.makeWebRequest("http://127.0.0.1:" + WheelData.webServerPort + "/actions/toggleFrontLight", null, options, null);
                break;
            }
        }
        WatchUi.requestUpdate();
    }
}


// Just a dummy class to shut up the API
class ActionConnectionListener extends Communications.ConnectionListener {
    function initialize() {
        ConnectionListener.initialize();
    }

    function onComplete() {

    }

    function onError() {

    }
}