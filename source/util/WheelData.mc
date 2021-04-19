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

    var webServerPort;
    var isWheelLogConnected = false;

    var webServerApiInstance = null;

    var dataUpdateTimer = new Timer.Timer();

    function setIsWheelLogConnected(data) {
        var previousState = isWheelLogConnected;
        isWheelLogConnected = data;

        if (isWheelLogConnected == true) {
            WatchUi.popView(WatchUi.SLIDE_DOWN);
            if (WheelData.dataUpdateTimer == null) {
                dataUpdateTimer.start(method(:WheelLog_getData), 200, true); // Start a timer routine for constantly getting data from the phone
            }
        } else if (isWheelLogConnected == false) {
            var progressBar = new WatchUi.ProgressBar(WatchUi.loadResource(Rez.Strings.LoadingScreen_WaitingConnectionWithApp), null);
            WatchUi.pushView(progressBar, new WaitingForConnectionViewDelegate(), WatchUi.SLIDE_UP);
            if (WheelData.dataUpdateTimer == null) {
                dataUpdateTimer.stop(); // Shut down timer, bc it will malfunction if no server is up and running
            }
        }
    }

    var CurrentSpeedMaxValue = 40;
}