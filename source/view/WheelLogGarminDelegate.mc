using Toybox.WatchUi;

class WheelLogGarminDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        // WatchUi.pushView(new Rez.Menus.MainMenu(), new WheelLogGarminMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onNextPage() {
        System.println("down");
        WatchUi.pushView(new DetailView(), new DetailViewDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
}