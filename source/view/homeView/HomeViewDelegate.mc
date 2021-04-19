using Toybox.WatchUi;

class HomeViewDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        // WatchUi.pushView(new Rez.Menus.MainMenu(), new WheelLogGarminMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onNextPage() {
        WatchUi.switchToView(new DetailView(), new DetailViewDelegate(new DetailView()), WatchUi.SLIDE_UP);
        return true;
    }
}