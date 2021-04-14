using Toybox.Communications;
using Toybox.Lang;
using Toybox.WatchUi;
using Toybox.Timer;

function mailHandler(mailIter) {
    var mail;
    mail = mailIter.next();
    Communications.emptyMailbox();

    if (mail != null && mail instanceof Lang.Dictionary) {
            WheelData.webServerPort = mail;
            WheelData.setIsWheelLogConnected(true);
    }

    if (WheelData.dataUpdateTimer == null) {
        dataUpdateTimer.start(method(:WheelLog_getData), 200, true); // Start a timer routine for constantly getting data from the phone
    }

    WatchUi.requestUpdate();
}