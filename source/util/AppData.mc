module AppData {
    var CurrentSpeed = 22,
        BatteryPercentage = 85,
        BatteryVoltage,
        Temperature = 16,
        Bluetooth,
        UseMph,
        MaxDialSpeed,
        RideTime,
        RideDistance,
        TopSpeed,
        Power,
        Pwm,
        AlarmType,
        BottomSutitleText;

    var CurrentSpeedMaxValue = 40;
    module Constants {
        module MessageType {
            module Outcoming {
                enum {
                    PLAY_HORN = 1
                }
            }
            module Incoming {
                enum {
                    EUC_DATA = 0,
                    SETTINGS = 2
                }
            }
            enum {
                MSG_TYPE = -2,
                MSG_DATA = -1,
            }
        }

        module MailKeys {
            module WheeLData {
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
                    RIDE_DISTANCE = 9;
                    RIDE_TIME = 10;
                }
            }
            module Settings {
                enum {
                    MAX_DIAL_SPEED = 0, // For anyone wondering what tf is dis. This key is for max speed that can be shown on the speed dial before it exeeds it's boundaries. I hope i explained it good
                    USE_MPH = 1
                }
            }
        }
    }
}