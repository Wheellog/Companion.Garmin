using Toybox.Communications;
using Toybox.WatchUi;
using Toybox.Attention;

function phoneAppMessageHandler(message) {
    var data = message.data;
    Communications.emptyMailbox();

    if (data != null) {
        if (data instanceof Number) { // If connection message is in v2 protocol
            // Play connection tone
            if (Attention has :playTone) {
                Attention.playTone(ToneProfiles.appConnectionTone);
            }
            AppStorage.runtimeDb["comm_protocolVersion"] = 2

            // Assign the server port
            WheelData.webServerPort = data;
            
            // And set connection state
            WheelData.setIsAppConnected(true);
        } else if (data instanceof Dictionary) { // If connection message in v3+ protocol
            if (data["dataType"] == "connect") {
                // Play connection tone
                if (Attention has :playTone) {
                    Attention.playTone(ToneProfiles.appConnectionTone);
                }
                AppStorage.runtimeDb["comm_protocolVersion"] = data["protocolVersion"];
                AppStorage.runtimeDb["misc_wheelLogVersion"] = data["wheelLogVersion"];

                // Assign the server port
                WheelData.webServerPort = data["serverPort"];
                
                // And set connection state
                WheelData.setIsAppConnected(true);
            } else if (data["dataType"] == "alarmUpdate") {
                WheelData.alarmType = data["alarmType"];
                Alarms.alarmHandler();
            }
        }
    }

    WatchUi.requestUpdate();
}