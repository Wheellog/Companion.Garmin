function parseDataFromWheelLog(message) {
    var type = message[WheelData.Constants.MessageType.MSG_TYPE];
    var data = message.get(WheelData.Constants.MessageType.MSG_DATA);
        
    if (type == null or data == null) {	
        return;
    }
    
    if (type == WheelData.Constants.MessageType.Incoming.EUC_DATA) {
        // Here we will parse data from WheelLog and put it into respectable variables

        var keyStore = WheelData.Constants.MailKeys.WheeLData;
        
        WheelData.CurrentSpeed = data[keyStore.CURRENT_SPEED];
        WheelData.BatteryPercentage = data.get(keyStore.BATTERY_PERCENTAGE);
        WheelData.BatteryVoltage = data.get(keyStore.BATTERY_VOLTAGE);
        WheelData.Temperature = data.get(keyStore.TEMPERATURE);
        WheelData.Bluetooth = data.get(keyStore.BT_STATE);
        WheelData.UseMph = data.get(keyStore.USE_MPH);
        WheelData.MaxDialSpeed = data.get(keyStore.MAX_DIAL_SPEED);
        WheelData.RideTime = data.get(keyStore.RIDE_TIME);
        WheelData.RideDistance = data.get(keyStore.RIDE_DISTANCE);
        WheelData.TopSpeed = data.get(keyStore.TOP_SPEED);
        WheelData.Power = data.get(keyStore.POWER);
    }
}