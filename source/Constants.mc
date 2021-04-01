module WheelLogAppConstants {
    enum {
        MESSAGE_TYPE_EUC_DATA = 0,
        MESSAGE_TYPE_PLAY_HORN = 1
    }

    module MailKeys {
        enum {
            MSG_TYPE = -2,
            MSG_DATA,

            CURRENT_SPEED,
            BATTERY_PERCENTAGE,
            BATTERY_VOLTAGE,
            TEMPERATURE,
            BT_STATE,
            USE_MPH,
            MAX_DIAL_SPEED, // For anyone wondering what tf is dis. This key is for max speed that can be shown on the speed dial before it exeeds it's boundaries. I hope i explained it good
            RIDE_TIME,
            RIDE_DISTANCE,
            TOP_SPEED,
            POWER,
            FIRST_ALARM_SPEED,
            SECOND_ALARM_SPEED,
            THIRD_ALARM_SPEED,
            WHEEEL_HAME,
        }
    }
}