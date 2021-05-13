using Toybox.Communications;
using Toybox.WatchUi;
using Toybox.Attention;

function mailHandler(mailIter) {
    var mail;
    mail = mailIter.next();
    Communications.emptyMailbox();

    if (mail != null) {
        // Play connection tone
        Attention.playTone(ToneProfiles.appConnectionTone);

        // Assign the server port
        WheelData.webServerPort = mail;
        
        // And set connection state
        WheelData.setIsAppConnected(true);
    }

    WatchUi.requestUpdate();
}