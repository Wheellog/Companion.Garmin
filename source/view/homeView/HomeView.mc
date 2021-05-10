using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;

class HomeView extends WatchUi.View {

    private var cDrawables = {};

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.HomeLayout(dc));
        // Label drawables
        cDrawables[:TimeDate] = View.findDrawableById("TimeDate");
        cDrawables[:SpeedNumber] = View.findDrawableById("SpeedNumber");
        cDrawables[:BatteryNumber] = View.findDrawableById("BatteryNumber");
        cDrawables[:TemperatureNumber] = View.findDrawableById("TemperatureNumber");
        cDrawables[:BottomSubtitle] = View.findDrawableById("BottomSubtitle");
        // And arc drawables
        cDrawables[:SpeedArc] = View.findDrawableById("SpeedDial");
        cDrawables[:BatteryArc] = View.findDrawableById("BatteryArc");
        cDrawables[:TemperatureArc] = View.findDrawableById("TemperatureArc");

        if (!WheelData.isAppConnected) {
            setIsAppConnected(false);
        }

        WheelData.webDataSource = "home";
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        var CurrentTime = System.getClockTime(); 
        cDrawables[:TimeDate].setText(
            CurrentTime.hour.format("%d") +
            ":" +
            CurrentTime.min.format("%02d")
        );

        if (AppStorage.getValue("AppTheme") == 0) {
            cDrawables[:TimeDate].setColor(Graphics.COLOR_BLACK);
        } else {
            cDrawables[:TimeDate].setColor(Graphics.COLOR_WHITE);
        }
    }

    // Update the view
    function onUpdate(dc) {
        // Update label drawables
        cDrawables[:TimeDate].setText( // Update time
            System.getClockTime().hour.format("%d") +
            ":" +
            System.getClockTime().min.format("%02d")
        );
        cDrawables[:BatteryNumber].setText(Lang.format("$1$%", [WheelData.batteryPercentage]));
        cDrawables[:TemperatureNumber].setText(Lang.format("$1$°", [WheelData.temperature]));
        if (AppStorage.runtimeCache["ui_messageDisplayCountdown"] != null && AppStorage.runtimeCache["ui_messageDisplayCountdown"] != 0) {
            AppStorage.runtimeCache["ui_messageDisplayCountdown"]--;
            cDrawables[:BottomSubtitle].setText(AppStorage.runtimeCache["ui_messageText"]);
        } else {
            cDrawables[:BottomSubtitle].setText(Lang.format("$1$% / $2$%", [WheelData.pwm, WheelData.maxPwm]));
        }
        var speedNumber;
        if (WheelData.currentSpeed.toNumber() >= 10) {
            speedNumber = WheelData.currentSpeed.toNumber();
        } else {
            speedNumber = WheelData.currentSpeed;
        }
        cDrawables[:SpeedNumber].setText(speedNumber.toString());

        if (AppStorage.getValue("ShowPwmInsteadOfSpeed") == true) {
            cDrawables[:SpeedArc].setValues(WheelData.pwm.toNumber(), 100);
        } else {
            cDrawables[:SpeedArc].setValues(WheelData.currentSpeed.toFloat(), WheelData.maxDialSpeed);
        }
        cDrawables[:BatteryArc].setValues(WheelData.batteryPercentage, 100);
        cDrawables[:TemperatureArc].setValues(WheelData.temperature, 50);

        // Theme coloring
        if (AppStorage.getValue("AppTheme") == 0) {
            cDrawables[:TimeDate].setColor(Graphics.COLOR_BLACK);
            cDrawables[:SpeedNumber].setColor(Graphics.COLOR_BLACK);
            cDrawables[:BatteryNumber].setColor(Graphics.COLOR_BLACK);
            cDrawables[:TemperatureNumber].setColor(Graphics.COLOR_BLACK);
            cDrawables[:BottomSubtitle].setColor(Graphics.COLOR_BLACK);
        } else {
            cDrawables[:TimeDate].setColor(Graphics.COLOR_WHITE);
            cDrawables[:SpeedNumber].setColor(Graphics.COLOR_WHITE);
            cDrawables[:BatteryNumber].setColor(Graphics.COLOR_WHITE);
            cDrawables[:TemperatureNumber].setColor(Graphics.COLOR_WHITE);
            cDrawables[:BottomSubtitle].setColor(Graphics.COLOR_WHITE);
        }

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    function onHide() {

    }	
}