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
        Attention.playTone(Attention.TONE_ALERT_HI);
        WheelData.webServerPort = mail;
        WheelData.setIsAppConnected(true);
    }

    WatchUi.requestUpdate();
}