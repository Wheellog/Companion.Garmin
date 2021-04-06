using Toybox.Attention;
using Toybox.Timer;

module Alarms {
    var alarmUpdateTimer = new Timer.Timer();
    function startAlarmRoutine(updateTime) {
        alarmUpdateTimer.start(method(:alarmHandler), updateTime, true);
    }

    function stopAlarmRoutine() {
        alarmUpdateTimer.stop();
    }

    function alarmHandler() {
        if (isAlarmTriggered) {

        }
    }

    module VibrationPatters {
        var firstAlarm = [
            new Attention.VibeProfile(30, 700), // On for 700 milliseconds
            new Attention.VibeProfile(0, 700),  // Off for 700 milliseconds
            new Attention.VibeProfile(30, 700), // And so on...
            new Attention.VibeProfile(0, 700)
        ];
        var secondAlarm = [
            new Attention.VibeProfile(50, 500),
            new Attention.VibeProfile(0, 500),
            new Attention.VibeProfile(50, 500),
            new Attention.VibeProfile(0, 500)
        ];
        var thirdAlarm = [
            new Attention.VibeProfile(50, 300),
            new Attention.VibeProfile(0, 300),
            new Attention.VibeProfile(50, 300),
            new Attention.VibeProfile(0, 300)
        ];
    }

    module Data {
        module AlarmType {
            enum {
                FIRST,
                SECOND,
                THIRD
            }
        }
        var isAlarmTriggered;

        var alarmType;
    }
}
