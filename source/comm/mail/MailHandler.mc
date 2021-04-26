using Toybox.Communications;
using Toybox.Lang;
using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.System;

function mailHandler(mailIter) {
    var mail;
    mail = mailIter.next();
    Communications.emptyMailbox();

    if (mail != null) {
            WheelData.webServerPort = mail;
            WheelData.webDataSource = "home";
            WheelData.webServerApiInstance = new WebServer(WheelData.webServerPort);
            WheelData.setIsAppConnected(true);
    }

    WatchUi.requestUpdate();
}