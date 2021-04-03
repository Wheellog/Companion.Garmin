function parseDataFromWheelLog(message) {
    var type = message.get(WheelLogAppConstants.MailKeys.MSG_TYPE);
    var data = message.get(WheelLogAppConstants.MailKeys.MSG_DATA);
        
    if (type == null or data == null) {	
        return;
    }
    
    if (type == WheelLogAppConstants.MessageType.EUC_DATA) {
        // Here we will parse data from WheelLog and put it into respectable variables
        
        mBatteryPercentage = data.get(WheelLogAppConstants.MailKeys.BATTERY_PERCENTAGE);
        mBatteryVoltage = data.get(WheelLogAppConstants.MailKeys.BATTERY_VOLTAGE);
        mTemperature = data.get(WheelLogAppConstants.MailKeys.TEMPERATURE);
        mRideTime = data.get(WheelLogAppConstants.MailKeys.RIDE_TIME);
        mRideDistance = data.get(WheelLogAppConstants.MailKeys.RIDE_DISTANCE);
        mTopSpeed = data.get(WheelLogAppConstants.MailKeys.TOP_SPEED);
        mPower = data.get(WheelLogAppConstants.MailKeys.POWER);
        mFirstAlarmSpeed = data.get(WheelLogAppConstants.MailKeys.FIRST_ALARM_SPEED);
        mSecondAlarmSpeed = data.get(WheelLogAppConstants.MailKeys.SECOND_ALARM_SPEED);
        mThirdAlarmSpeed = data.get(WheelLogAppConstants.MailKeys.THIRD_ALARM_SPEED);
    }
}