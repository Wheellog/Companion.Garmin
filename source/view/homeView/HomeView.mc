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
        cDrawables[:SpeedArc] = View.findDrawableById("SpeedArc");
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
        cDrawables[:BottomSubtitle].setText(WheelData.bottomSubtitle);
        var currentSpeed = 0;
        if (WheelData.currentSpeed < 10) {
            currentSpeed = WheelData.currentSpeed;
        } else {
            currentSpeed = WheelData.currentSpeed / 10;
        }
        cDrawables[:SpeedNumber].setText(currentSpeed.toString());

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {

    }	
}