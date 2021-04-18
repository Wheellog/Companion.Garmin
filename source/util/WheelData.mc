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
        bottomSubtitleText = "";

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
    module Constants {
        module Data {
            enum {
                CurrentSpeed = 0,
                BatteryPercentage = 1,
                BatteryVoltage = 2,
                Temperature = 3,
                BtState = 4,
                Power = 5,
                BottomSubtitle = 6,
                AverageSpeed = 7,
                TopSpeed = 8,
                RideDistance = 9,
                RideTime = 10,
                Pwm = 11,
                MaxPwm = 12,
                AlarmType = 13,
                MaxDialSpeed = 14, // For anyone wondering what tf is dis. This key is for max speed that can be shown on the speed dial before it exeeds it's boundaries. I hope i explained it good
                UseMph = 15
            }
        }
    }
}