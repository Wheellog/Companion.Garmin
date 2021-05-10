using Toybox.Communications;
using Toybox.WatchUi;
using Toybox.Attention;

function mailHandler(mailIter) {
    var mail;
    mail = mailIter.next();
    Communications.emptyMailbox();

    if (mail != null) {
        // Write values to runtime cache
        AppStorage.runtimeCache["ui_messageDisplayCountdown"] = 5;
        AppStorage.runtimeCache["ui_messageText"] = Rez.Strings.Message_AppСonnected;

        // Play connection tone
        Attention.playTone(Attention.TONE_ALERT_HI);

        // Assign the server port
        WheelData.webServerPort = mail;
        
        // And set connection state
        WheelData.setIsAppConnected(true);
    }

    WatchUi.requestUpdate();
}