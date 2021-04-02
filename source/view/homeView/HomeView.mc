using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;

class HomeView extends WatchUi.View {

    private var progressBar, isProgressBarShown;

    private var mCurrentSpeed,
        mBatteryPercentage,
        mBatteryVoltage,
        mTemperature,
        mBluetooth,
        mUseMph,
        mMaxDialSpeed,
        mRideTime,
        mRideDistance,
        mTopSpeed,
        mPower,
        mFirstAlarmSpeed,
        mSecondAlarmSpeed,
        mThirdAlarmSpeed;

    private var mDrawables = {};

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.HomeLayout(dc));
        Communications.setMailboxListener(method(:onMail));   

        progressBar = new WatchUi.ProgressBar(
            WatchUi.loadResource(Rez.Strings.LoadingScreen_WaitingConnectionWithApp),
            null
        );
        // WatchUi.pushView(progressBar, new WaitingForConnectionViewDelegate(), WatchUi.SLIDE_UP );
        isProgressBarShown = true;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        mDrawables[:TimeDate] = View.findDrawableById("TimeDate");
        var CurrentTime = System.getClockTime(); 
        mDrawables[:TimeDate].setText(
            CurrentTime.hour.format("%d") +
            ":" +
            CurrentTime.min.format("%02d")
        );
    }

    // Update the view
    function onUpdate(dc) {
        View.findDrawableById("TimeDate").setText(System.getClockTime().hour.format("%d") + ":" + System.getClockTime().min.format("%02d"));

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {

    }

    function onMail(mailIter) {
        var mail;
        mail = mailIter.next();
        Communications.emptyMailbox();

        // Here we hide the waiting screen, which waits for connection with WheelLog
        if(isProgressBarShown == true) {
            progressBar.popView(WatchUi.SLIDE_DOWN);
        }

        if (mail != null && mail instanceof Lang.Dictionary) {
                parseMessage(mail);
        }

        WatchUi.requestUpdate();
    }

    function parseMessage(message) {
		var type = message.get(WheelLogAppConstants.MailKeys.MSG_TYPE);
		var data = message.get(WheelLogAppConstants.MailKeys.MSG_DATA);
			
		if (type == null or data == null) {	
			return;
		}
		
		if (type == WheelLogAppConstants.MessageType.EUC_DATA) {
            // Here we will parse data from WheelLog and put it into respectable variables
            
            mCurrentSpeed = data.get(WheelLogAppConstants.MailKeys.CURRENT_SPEED);
            mBatteryPercentage = data.get(WheelLogAppConstants.MailKeys.BATTERY_PERCENTAGE);
            mBatteryVoltage = data.get(WheelLogAppConstants.MailKeys.BATTERY_VOLTAGE);
            mTemperature = data.get(WheelLogAppConstants.MailKeys.TEMPERATURE);
            mBluetooth = data.get(WheelLogAppConstants.MailKeys.BT_STATE);
            mUseMph = data.get(WheelLogAppConstants.MailKeys.USE_MPH);
            mMaxDialSpeed = data.get(WheelLogAppConstants.MailKeys.MAX_DIAL_SPEED);
            mRideTime = data.get(WheelLogAppConstants.MailKeys.RIDE_TIME);
            mRideDistance = data.get(WheelLogAppConstants.MailKeys.RIDE_DISTANCE);
            mTopSpeed = data.get(WheelLogAppConstants.MailKeys.TOP_SPEED);
            mPower = data.get(WheelLogAppConstants.MailKeys.POWER);
            mFirstAlarmSpeed = data.get(WheelLogAppConstants.MailKeys.FIRST_ALARM_SPEED);
            mSecondAlarmSpeed = data.get(WheelLogAppConstants.MailKeys.SECOND_ALARM_SPEED);
            mThirdAlarmSpeed = data.get(WheelLogAppConstants.MailKeys.THIRD_ALARM_SPEED);
		}
    }
}