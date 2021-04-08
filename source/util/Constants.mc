module WheelLogAppConstants {
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
            EUC_DATA = 0,
            PLAY_HORN = 1
        }
    }

    module MailKeys {
        enum {
            MSG_TYPE = -2,
            MSG_DATA = -1,
        }
        module WheeLData {
            enum {
                CURRENT_SPEED = 0,
                BATTERY_PERCENTAGE = 1,
                BATTERY_VOLTAGE = 2,
                TEMPERATURE = 3,
                BT_STATE = 4,
                RIDE_TIME = 5,
                RIDE_DISTANCE = 6,
                TOP_SPEED = 7,
                POWER = 8,
                BOTTOM_SUBTITLE = 9,
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