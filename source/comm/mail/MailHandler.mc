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
            WheeData.webDataSource = "home";
            WheelData.webServerApiInstance = new WebServerApi(WheelData.webServerPort);
            WheelData.setIsAppConnected(true);
    }

    WatchUi.requestUpdate();
}