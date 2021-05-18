using Toybox.Communications;
using Toybox.WatchUi;
using Toybox.Attention;

function phoneAppMessageHandler(message) {
    var data = message.data;
    Communications.emptyMailbox();

    if (data != null) {
        // Play connection tone
        if (Attention has :playTone) {
            Attention.playTone(ToneProfiles.appConnectionTone);
        }

        // Assign the server port
        WheelData.webServerPort = data;
        
        // And set connection state
        WheelData.setIsAppConnected(true);
    }

    WatchUi.requestUpdate();
}