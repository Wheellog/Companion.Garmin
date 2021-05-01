using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using Toybox.Graphics;

var detailView_currentlyOnScreen = 0;
var detailView_maxScreens = 2; // Start to count from 0

class DetailView extends WatchUi.View {
    private var cDrawables = {}; // cached drawables
    private var cStrings = {}; // and also cached strings

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.DetailsLayout(dc));

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
        cStrings[:SpeedData] = WatchUi.loadResource(Rez.Strings.DetailView_SpeedData);
        cStrings[:BatteryVoltageData] = WatchUi.loadResource(Rez.Strings.DetailView_BatteryVoltageData);
        cStrings[:BatteryPercentageData] = WatchUi.loadResource(Rez.Strings.DetailView_BatteryPercentageData);
        cStrings[:RideDistanceData] = WatchUi.loadResource(Rez.Strings.DetailView_RideDistanceData);

        WheelData.webDataSource = "details";

        dc.setColor(Graphics.COLOR_BLUE, 0x000000);
        dc.setPenWidth(15);
        dc.drawText(100, 100, Graphics.FONT_LARGE, "", Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        
    }

    // Update the view
    function onUpdate(dc) {
        switch (detailView_currentlyOnScreen) {
            case 0:
                // Set names
                cDrawables[:FirstSectionLabel].setText(cStrings[:AverageSpeed]);
                cDrawables[:SecondSectionLabel].setText(cStrings[:TopSpeed]);
                // And values
                cDrawables[:FirstSectionData].setText(Lang.format(cStrings[:SpeedData], [WheelData.averageSpeed]));
                cDrawables[:SecondSectionData].setText(Lang.format(cStrings[:SpeedData], [WheelData.topSpeed]));
                break;
            case 1:
                // Set names
                cDrawables[:FirstSectionLabel].setText(cStrings[:Voltage]);
                cDrawables[:SecondSectionLabel].setText(cStrings[:BatteryPercentage]);

                cDrawables[:FirstSectionData].setText(Lang.format(cStrings[:BatteryVoltageData], [WheelData.batteryVoltage]));
                cDrawables[:SecondSectionData].setText(Lang.format(cStrings[:BatteryPercentageData], [WheelData.batteryPercentage]));
                break;
            case 2:
                // Set names
                cDrawables[:FirstSectionLabel].setText(cStrings[:RideTime]);
                cDrawables[:SecondSectionLabel].setText(cStrings[:Distance]);

                cDrawables[:FirstSectionData].setText(WheelData.rideTime);
                cDrawables[:SecondSectionData].setText(Lang.format(cStrings[:RideDistanceData], [WheelData.rideDistance]));
                break;
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
        if (detailView_currentlyOnScreen == 0) {
            WatchUi.switchToView(new HomeView(), new HomeViewDelegate(), WatchUi.SLIDE_DOWN);
        } else {
            detailView_currentlyOnScreen--;
        }
        WatchUi.requestUpdate();
    }

    function moveDown() {
        if (detailView_currentlyOnScreen != detailView_maxScreens) {
            detailView_currentlyOnScreen++;
        }
        WatchUi.requestUpdate();
    }
}