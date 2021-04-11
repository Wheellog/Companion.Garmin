using Toybox.Communications;
using Toybox.Lang;
using Toybox.WatchUi;

function mailHandler(mailIter) {
    var mail;
    mail = mailIter.next();
    Communications.emptyMailbox();

    if (mail != null && mail instanceof Lang.Dictionary) {
            parseDataFromWheelLog(mail);
    }

    WatchUi.requestUpdate();
}