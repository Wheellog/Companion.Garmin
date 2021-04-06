function parseDataFromWheelLog(message) {
var type = message.get(WheelLogAppConstants.MailKeys.MSG_TYPE);
    var data = message.get(WheelLogAppConstants.MailKeys.MSG_DATA);
        
    if (type == null or data == null) {	
        return;
    }
    
    if (type == WheelLogAppConstants.MessageType.EUC_DATA) {
        // Here we will parse data from WheelLog and put it into respectable variables
        
        WheelData.CurrentSpeed = data.get(WheelLogAppConstants.MailKeys.CURRENT_SPEED);
        WheelData.BatteryPercentage = data.get(WheelLogAppConstants.MailKeys.BATTERY_PERCENTAGE);
        WheelData.BatteryVoltage = data.get(WheelLogAppConstants.MailKeys.BATTERY_VOLTAGE);
        WheelData.Temperature = data.get(WheelLogAppConstants.MailKeys.TEMPERATURE);
        WheelData.Bluetooth = data.get(WheelLogAppConstants.MailKeys.BT_STATE);
        WheelData.UseMph = data.get(WheelLogAppConstants.MailKeys.USE_MPH);
        WheelData.MaxDialSpeed = data.get(WheelLogAppConstants.MailKeys.MAX_DIAL_SPEED);
        WheelData.RideTime = data.get(WheelLogAppConstants.MailKeys.RIDE_TIME);
        WheelData.RideDistance = data.get(WheelLogAppConstants.MailKeys.RIDE_DISTANCE);
        WheelData.TopSpeed = data.get(WheelLogAppConstants.MailKeys.TOP_SPEED);
        WheelData.Power = data.get(WheelLogAppConstants.MailKeys.POWER);
    }
}