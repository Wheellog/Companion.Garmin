module WheelLogAppConstants {
    enum {
        MESSAGE_TYPE_EUC_DATA = 0,
        MESSAGE_TYPE_PLAY_HORN = 1
    }

    module MailKeys {
        enum {
            MSG_TYPE = -2,
            MSG_DATA = -1,

            CURRENT_SPEED = 0,
            BATTERY_PERCENTAGE = 1,
            BATTERY_VOLTAGE = 2,
            TEMPERATURE = 3,
            BT_STATE = 4,
            USE_MPH = 5,
            MAX_DIAL_SPEED = 6, // For anyone wondering what tf is dis. This key is for max speed that can be shown on the speed dial before it exeeds it's boundaries. I hope i explained it good
            RIDE_TIME = 7,
            RIDE_DISTANCE = 8,
            TOP_SPEED = 9,
            POWER = 10,
            FIRST_ALARM_SPEED = 11,
            SECOND_ALARM_SPEED = 12,
            THIRD_ALARM_SPEED = 13,
            WHEEEL_HAME = 14,
        }
    }
}