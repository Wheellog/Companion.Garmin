using Toybox.WatchUi;

class HomeViewDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        return true;
    }

    function onSelect() {
        Actions.triggerHorn();
    }

    function onNextPage() {
        WatchUi.switchToView(new DetailView(), new DetailViewDelegate(new DetailView()), WatchUi.SLIDE_UP);
        return true;
    }
}