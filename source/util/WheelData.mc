module WheelData {
    var CurrentSpeed = 0,
        BatteryPercentage = 0,
        BatteryVoltage,
        Temperature = 0,
        Bluetooth,
        UseMph,
        MaxDialSpeed,
        RideTime,
        RideDistance,
        AverageSpeed,
        TopSpeed,
        Power,
        Pwm,
        MaxPwm,
        AlarmType,
        BottomSubtitleText = "";

    var webServerPort;

    var CurrentSpeedMaxValue = 40;
    module Constants {
        module MessageType {
            enum {
                PLAY_HORN = 1,
                EUC_DATA = 0
            }
            enum {
                MSG_TYPE = -2,
                MSG_DATA = -1
            }
        }

        module MailKeys {
            module Data {
                enum {
                    CURRENT_SPEED = 0,
                    BATTERY_PERCENTAGE = 1,
                    BATTERY_VOLTAGE = 2,
                    TEMPERATURE = 3,
                    BT_STATE = 4,
                    POWER = 5,
                    BOTTOM_SUBTITLE = 6,
                    AVG_SPEED = 7,
                    TOP_SPEED = 8,
                    RIDE_DISTANCE = 9,
                    RIDE_TIME = 10,
                    PWM = 11,
                    MAX_PWM = 12,
                    ALARM_TYPE = 13,
                    MAX_DIAL_SPEED = 14, // For anyone wondering what tf is dis. This key is for max speed that can be shown on the speed dial before it exeeds it's boundaries. I hope i explained it good
                    USE_MPH = 15
                }
            }
        }
    }
}