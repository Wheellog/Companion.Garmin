using Toybox.Communications;
using Toybox.Lang;
using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.System;

function mailHandler(mailIter) {
    var mail;
    mail = mailIter.next();
    Communications.emptyMailbox();

    System.println("Got mail!");

    if (mail != null) {
            WheelData.webServerPort = mail;
            WheelData.setisAppConnected(true);
    }

    WatchUi.requestUpdate();
}