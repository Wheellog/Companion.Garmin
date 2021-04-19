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
        } else if (isWheelLogConnected == false) {
            var progressBar = new WatchUi.ProgressBar(WatchUi.loadResource(Rez.Strings.LoadingScreen_WaitingConnectionWithApp), null);
            WatchUi.pushView(progressBar, new WaitingForConnectionViewDelegate(), WatchUi.SLIDE_UP);
        }
    }

    var CurrentSpeedMaxValue = 40;
}