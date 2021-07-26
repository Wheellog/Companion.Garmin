import Toybox.Communications;
import Toybox.WatchUi;
import Toybox.Attention;
import Toybox.Lang;
import Toybox.System;

function phoneAppMessageHandler(msg as Communications.Message) {
    var data = msg.data;
    Communications.emptyMailbox();

    if (data != null) {
        if (data instanceof Lang.Number) { // If the message is in v2 protocol
            // Play connection tone
            if (Attention has :playTone) {
                Attention.playTone(ToneProfiles.appConnectionTone);
            }
            AppStorage.runtimeDb["comm_protocolVersion"] = 2;

            // Assign the server port
            WheelData.webServerPort = data;
            
            // And set connection state
            WheelData.setIsAppConnected(true);
        } else if (data instanceof Lang.Array) { // v3+ protocol
            switch (data[0]) {
                case "c": { // Connection
                    // Play connection tone
                    if (Attention has :playTone) {
                        Attention.playTone(ToneProfiles.appConnectionTone);
                    }
                    AppStorage.runtimeDb["comm_protocolVersion"] = data[1];
                    WheelData.webServerPort = data[2]; // Assign the server port
                    
                    // And set connection state
                    WheelData.setIsAppConnected(true);
                    break;
                }
                case "a": { // Alarm update
                    Alarms.alarmHandler(data[1].toNumber());
                    break;
                }
                case "s": { // Settings sync (e.g. info blocks)
                    break;
                }
            }
        }
    }

    WatchUi.requestUpdate();
}