import Toybox.Communications;
import Toybox.WatchUi;
import Toybox.Attention;
import Toybox.Lang;
import Toybox.System;
import CIQVec;

function phoneAppMessageHandler(msg as Communications.Message) {
    try {
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

                        updateIndexManifest(generateIndexManifest(:mainScreenData));
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
    } catch (e) {
        System.println("Failed to execute");
    }
}

function updateIndexManifest(manifest as CIQVec.Vector) {
    Communications.transmit(manifest.toArray(), {}, new IndexManifestConnectionListener());
}

function generateIndexManifest(manifestFor as Symbol or Null) {
    var indexManifest = new CIQVec.Vector();
    switch (manifestFor) {
        case :mainScreenData: {
            indexManifest.push("speed");
            indexManifest.push("battery%");
            indexManifest.push("battery%LoadDrop");
            indexManifest.push("temperature");
            indexManifest.push("isMph");
            indexManifest.push("pwm");
            indexManifest.push("maxPwm");
            indexManifest.push("maxSpeed")

            switch (AppStorage.getSetting("BottomSubtitleData")) {
                case 0: indexManifest.push("wheelModel"); break;
                case 2: indexManifest.push("avgSpeed"); indexManifest.push("topSpeed"); break;
                case 3: indexManifest.push("rideTime"); break;
                case 4: indexManifest.push("distance");
                default: break;
            }
        }
        case :detailScreenData: {
            indexManifest.push("avgSpeed");
            indexmanifest.push("topSpeed");
            indexManifest.push("voltage");
            indexManifest.push("battery%");
            indexManifest.push("rideTime");
            indexManifest.push("distance");
        }
    }
    return indexManifest
}
