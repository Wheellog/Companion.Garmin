using Toybox.Communications;
using Toybox.Lang;
using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.System;
using Toybox.Attention;

function mailHandler(mailIter) {
    var mail;
    mail = mailIter.next();
    Communications.emptyMailbox();

    if (mail != null) {
        System.println(WheelData.isAppConnected);
        AppStorage.runtimeCache["ui_messageDisplayCountdown"] = 5;
        if (WheelData.isAppConnected) {
            AppStorage.runtimeCache["ui_messageText"] = Rez.Strings.Message_AppReconnected;
        } else {
            AppStorage.runtimeCache["ui_messageText"] = Rez.Strings.Message_AppСonnected;
        }
        Attention.playTone(Attention.TONE_ALERT_HI);
        WheelData.webServerPort = mail;
        WheelData.setIsAppConnected(true);
    }

    WatchUi.requestUpdate();
}