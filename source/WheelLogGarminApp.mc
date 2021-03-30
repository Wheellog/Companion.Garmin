using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Application.Storage;

class WheelLogGarminApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
        Application.getApp().setProperty("showVoltageInsteadOfPercentage", true);
    }

    // onStart() is called on application start up
    function onStart(state) {
        System.println(state);

    }

    // onStop() is called when your application is exiting
    function onStop(state) {
        System.println(state);
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new WheelLogGarminView(), new WheelLogGarminDelegate() ];
    }
}
