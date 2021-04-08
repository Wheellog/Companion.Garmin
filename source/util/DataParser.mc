function parseDataFromWheelLog(message) {
    var type = message[AppData.Constants.MessageType.MSG_TYPE];
    var data = message.get(AppData.Constants.MessageType.MSG_DATA);
        
    if (type == null or data == null) {	
        return;
    }
    
    if (type == WheelLogAppConstants.MessageType.EUC_DATA) {
        // Here we will parse data from WheelLog and put it into respectable variables

        var keyStore = AppData.Constants.MailKeys.WheeLData;
        
        AppData.CurrentSpeed = data[keyStore.CURRENT_SPEED];
        AppData.BatteryPercentage = data.get(keyStore.BATTERY_PERCENTAGE);
        AppData.BatteryVoltage = data.get(keyStore.BATTERY_VOLTAGE);
        AppData.Temperature = data.get(keyStore.TEMPERATURE);
        AppData.Bluetooth = data.get(keyStore.BT_STATE);
        AppData.UseMph = data.get(keyStore.USE_MPH);
        AppData.MaxDialSpeed = data.get(keyStore.MAX_DIAL_SPEED);
        AppData.RideTime = data.get(keyStore.RIDE_TIME);
        AppData.RideDistance = data.get(keyStore.RIDE_DISTANCE);
        AppData.TopSpeed = data.get(keyStore.TOP_SPEED);
        AppData.Power = data.get(keyStore.POWER);
    }
}