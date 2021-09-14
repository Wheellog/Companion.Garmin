import Toybox.Communications;
import Toybox.WatchUi;
import Toybox.Attention;
import Toybox.Lang;
import Toybox.System;
import CIQVec;

function phoneAppMessageHandler(msg as Communications.Message) {
    var data = msg.data;

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
                    
                    var indexManifest = new CIQVec.Vector();
                    indexManifest.push("speed");
                    indexManifest.push("battery%");
                    indexManifest.push("battery%LoadDrop");
                    indexManifest.push("temperature");
                    indexManifest.push("isMph");
                    indexManifest.push("pwm");
                    indexManifest.push("maxPwm");

                    // And set connection state
                    WheelData.setIsAppConnected(true);
                    switch (AppStorage.getSetting("BottomSubtitleData")) {
                        case 0:
                    }
                    Communications.transmit(indexManifest.toArray(), {}, listener);
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