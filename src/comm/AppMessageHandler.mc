using Toybox.Communications;
using Toybox.WatchUi;
using Toybox.Attention;
using Toybox.Lang;
using Toybox.System;

function phoneAppMessageHandler(message) {
    var data = message.data;
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
        } else if (data instanceof Lang.Dictionary) { // If the message is in v3+ protocol
            switch (data["protocolVersion"]) {
                case 3: {
                    switch (data["dataType"]) {
                        case "connect": {
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
                            break;
                        }
                        case "alarmUpdate": {
                            Alarms.alarmHandler(data["alarmType"]);
                            break;
                        }
                    }
                }    
                default: {

                }
            }
        }
    }

    WatchUi.requestUpdate();
}