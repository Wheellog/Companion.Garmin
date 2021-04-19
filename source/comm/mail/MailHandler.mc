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

    WatchUi.requestUpdate();
}