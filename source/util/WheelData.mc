using Toybox.WatchUi;
using Toybox.Timer;

module WheelData {
    var currentSpeed = 0,
        batteryPercentage = 0,
        batteryVoltage,
        temperature = 0,
        bluetooth,
        useMph,
        maxDialSpeed,
        rideTime,
        rideDistance,
        averageSpeed,
        topSpeed,
        power,
        pwm,
        maxPwm,
        alarmType,
        bottomSubtitle = "";

    var CurrentSpeedMaxValue = 40;

    var webServerPort;
    var isAppConnected = false;

    var webServerApiInstance = null;
    var webDataSource;

    var dataUpdateTimer = new Timer.Timer();

    function setIsAppConnected(data) {
        var previousState = isAppConnected;
        isAppConnected = data;

        if (isAppConnected == true) {
            WatchUi.popView(WatchUi.SLIDE_DOWN);
            if (WheelData.dataUpdateTimer == null) {
                dataUpdateTimer.start(method(:WheelLog_getData), 200, true); // Start a timer routine for constantly getting data from the phone
            }
        } else if (isAppConnected == false) {
            var progressBar = new WatchUi.ProgressBar(WatchUi.loadResource(Rez.Strings.LoadingScreen_WaitingConnectionWithApp), null);
            WatchUi.pushView(progressBar, new WaitingForConnectionViewDelegate(), WatchUi.SLIDE_UP);
            if (WheelData.dataUpdateTimer == null) {
                dataUpdateTimer.stop(); // Shut down timer, bc it will malfunction if no server is up and running
            }
        }
    }
}

function WheelLog_getData() {
    webServerApiInstance.updateData(:alarms);
    switch (webDataSource) {
        case "home":
            webServerApiInstance.updateData(:main);
            break;
        case "details":
            webServerApiInstance.updateData(:details);
            break;
    }
    
}