using Toybox.WatchUi;

class DetailViewDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        return true;
    }

    function onPreviousPage() {
        System.println("up"); // e.g. KEY_MENU = 7
        return true;
    }
}