using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;

class HomeView extends WatchUi.View {

    private var progressBar, isProgressBarShown;

    private var cDrawables = {};

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.HomeLayout(dc));

        progressBar = new WatchUi.ProgressBar(
            WatchUi.loadResource(Rez.Strings.LoadingScreen_WaitingConnectionWithApp),
            null
        );
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

        // WatchUi.pushView(progressBar, new WaitingForConnectionViewDelegate(), WatchUi.SLIDE_UP );
        isProgressBarShown = true;
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
        cDrawables[:BatteryNumber].setText(Lang.format("$1$%", [WheelData.BatteryPercentage]));
        cDrawables[:TemperatureNumber].setText(Lang.format("$1$°", [WheelData.Temperature]));
        cDrawables[:BottomSubtitle].setText(WheelData.BottomSubtitleText);
        var currentSpeed = 0;
        if (WheelData.CurrentSpeed < 10) {
            currentSpeed = WheelData.CurrentSpeed;
        } else {
            currentSpeed = WheelData.CurrentSpeed / 10;
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