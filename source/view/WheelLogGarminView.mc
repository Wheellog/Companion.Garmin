using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;

class WheelLogGarminView extends WatchUi.View {

    private var progressBar, isProgressBarShown;

    private var mSpeed, mBattery, mTemperature, mBluetooth, mPower;

    private var mDrawables = {};

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
        Communications.setMailboxListener(method(:onMail));   

        progressBar = new WatchUi.ProgressBar(
            WatchUi.loadResource(Rez.Strings.LoadingScreen_WaitingConnectionWithApp),
            null
        );
        WatchUi.pushView(progressBar, new ProgressDelegate(), WatchUi.SLIDE_UP );
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

        if(isProgressBarShown == true) {
            progressBar.popView(WatchUi.SLIDE_DOWN);
        }

        if (mail != null && mail instanceof Lang.Dictionary) {
                parseMessage(mail);
        }

        WatchUi.requestUpdate();
    }

    function parseMessage(message) {
		var type = message.get(WheelLogAppConstants.KEY_MSG_TYPE);
		var data = message.get(WheelLogAppConstants.KEY_MSG_DATA);
			
		if (type == null or data == null) {	
			return;
		}
		
		if (type == WheelLogAppConstants.MESSAGE_TYPE_EUC_DATA) {
			mSpeed       = data.get(WheelLogAppConstants.KEY_SPEED);
			mBattery     = data.get(WheelLogAppConstants.KEY_BATTERY);
			mTemperature = data.get(WheelLogAppConstants.KEY_TEMPERATURE);
			mBluetooth   = data.get(WheelLogAppConstants.KEY_BT_STATE);
			mPower       = data.get(WheelLogAppConstants.KEY_POWER).abs();
		} else {

        }
	}
}
