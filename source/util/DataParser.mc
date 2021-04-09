function parseDataFromWheelLog(message) {
    var constantsStore = WheelData.Constants;

    var type = message[constantsStore.MessageType.MSG_TYPE];
    var data = message[constantsStore.MessageType.MSG_DATA];
        
    if (type == null or data == null) {	
        return;
    }
    
    switch (type) {
        case constantsStore.MessageType.Incoming.EUC_DATA: {
            // Here we will parse data from WheelLog and put it into respectable variables
            var keyStore = constantsStore.MailKeys.Data;
            
            WheelData.CurrentSpeed = data[keyStore.CURRENT_SPEED];
            WheelData.BatteryPercentage = data[keyStore.BATTERY_PERCENTAGE];
            WheelData.BatteryVoltage = data[keyStore.BATTERY_VOLTAGE];
            WheelData.Temperature = data[keyStore.TEMPERATURE];
            WheelData.Bluetooth = data[keyStore.BT_STATE];
            WheelData.RideTime = data[keyStore.RIDE_TIME];
            WheelData.RideDistance = data[keyStore.RIDE_DISTANCE];
            WheelData.AverageSpeed = data[keyStore.AVG_SPEED];
            WheelData.TopSpeed = data[keyStore.TOP_SPEED];
            WheelData.Power = data[keyStore.POWER];
            WheelData.Pwm = data[keyStore.PWM];
            WheelData.AlarmType = data[keyStore.ALARM_TYPE];
            WheelData.BottomSutitleText = data[keyStore.BOTTOM_SUBTITLE_TEXT];
        }
        case constantsStore.MessageType.Incoming.SETTINGS: {
            var keyStore = constantsStore.MailKeys.Settings;

            WheelData.UseMph = data[keyStore.USE_MPH];
            WheelData.MaxDialSpeed = data[keyStore.MAX_DIAL_SPEED];
        }
    }
}