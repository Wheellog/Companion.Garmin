using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;

var currentlyOnScreen = 0;
var maxScreens = 2; // Start to count from 0

class DetailView extends WatchUi.View {
    private var cDrawables = {};
    private var cStrings = {};

    private var mBatteryPercentage,
        mBatteryVoltage,
        mTemperature,
        mRideTime,
        mRideDistance,
        mTopSpeed,
        mPower,
        mFirstAlarmSpeed,
        mSecondAlarmSpeed,
        mThirdAlarmSpeed;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.DetailsLayout(dc));
        Communications.setMailboxListener(method(:onMail));

        // Here we cache every resource we will use in this view
        cDrawables[:FirstSectionLabel] = View.findDrawableById("FirstSectionLabel");
        cDrawables[:FirstSectionData] = View.findDrawableById("FirstSectionData");
        cDrawables[:SecondSectionLabel] = View.findDrawableById("SecondSectionLabel");
        cDrawables[:SecondSectionData] = View.findDrawableById("SecondSectionData");

        cStrings[:AverageSpeed] = Rez.Strings.DetailView_AverageSpeed;
        cStrings[:TopSpeed] = Rez.Strings.DetailView_TopSpeed;
        cStrings[:Voltage] = Rez.Strings.DetailView_Voltage;
        cStrings[:BatteryPercentage] = Rez.Strings.DetailView_BatteryPercentage;
        cStrings[:RideTime] = Rez.Strings.DetailView_RideTime;
        cStrings[:Distance] = Rez.Strings.DetailView_Distance;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        
    }

    function onMail(mailIter) {
        var mail;
        mail = mailIter.next();
        Communications.emptyMailbox();

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

    // Update the view
    function onUpdate(dc) {
        if (currentlyOnScreen == 0) {
=            cDrawables[:FirstSectionLabel].setText(cStrings[:AverageSpeed]);
            cDrawables[:SecondSectionLabel].setText(cStrings[:TopSpeed]);
        } else if (currentlyOnScreen == 1) {
            cDrawables[:FirstSectionLabel].setText(cStrings[:Voltage]);
            cDrawables[:SecondSectionLabel].setText(cStrings[:BatteryPercentage]);
        } else if (currentlyOnScreen == 2) {
            cDrawables[:FirstSectionLabel].setText(cStrings[:RideTime]);
            cDrawables[:SecondSectionLabel].setText(cStrings[:Distance]);
        }

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {

    }

    function moveUp() {
        if (currentlyOnScreen == 0) {
            WatchUi.switchToView(new HomeView(), new HomeViewDelegate(), WatchUi.SLIDE_DOWN);
        } else {
            currentlyOnScreen--;
        }
        WatchUi.requestUpdate();
    }

    function moveDown() {
        if (currentlyOnScreen != maxScreens) {
            currentlyOnScreen++;
        }
        WatchUi.requestUpdate();
    }
}