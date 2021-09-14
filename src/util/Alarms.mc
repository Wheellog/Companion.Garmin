import Toybox.Attention;
import Toybox.Timer;

module Alarms {
    function alarmHandler(alarmType) {
        if (alarmType != 0) {
            Attention.vibrate(alarmProfile);
        }
    }

    var alarmProfile = [
        new Attention.VibeProfile(2000, 100),
        new Attention.VibeProfile(2000, 100),
        new Attention.VibeProfile(2000, 100),
        new Attention.VibeProfile(2000, 100)
    ];
}
