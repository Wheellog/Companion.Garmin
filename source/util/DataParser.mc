function parseDataFromWheelLog(message) {
    var type = message[WheelLogAppConstants.MailKeys.MSG_TYPE];
    var data = message.get(WheelLogAppConstants.MailKeys.MSG_DATA);
        
    if (type == null or data == null) {	
        return;
    }
    
    if (type == WheelLogAppConstants.MessageType.EUC_DATA) {
        // Here we will parse data from WheelLog and put it into respectable variables
        
        AppData.CurrentSpeed = data[WheelLogAppConstants.MailKeys.CURRENT_SPEED];
        AppData.BatteryPercentage = data.get(WheelLogAppConstants.MailKeys.BATTERY_PERCENTAGE);
        AppData.BatteryVoltage = data.get(WheelLogAppConstants.MailKeys.BATTERY_VOLTAGE);
        AppData.Temperature = data.get(WheelLogAppConstants.MailKeys.TEMPERATURE);
        AppData.Bluetooth = data.get(WheelLogAppConstants.MailKeys.BT_STATE);
        AppData.UseMph = data.get(WheelLogAppConstants.MailKeys.USE_MPH);
        AppData.MaxDialSpeed = data.get(WheelLogAppConstants.MailKeys.MAX_DIAL_SPEED);
        AppData.RideTime = data.get(WheelLogAppConstants.MailKeys.RIDE_TIME);
        AppData.RideDistance = data.get(WheelLogAppConstants.MailKeys.RIDE_DISTANCE);
        AppData.TopSpeed = data.get(WheelLogAppConstants.MailKeys.TOP_SPEED);
        AppData.Power = data.get(WheelLogAppConstants.MailKeys.POWER);
    }
}