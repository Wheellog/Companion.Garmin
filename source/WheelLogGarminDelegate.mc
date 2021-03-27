using Toybox.WatchUi;

class WheelLogGarminDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new WheelLogGarminMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}