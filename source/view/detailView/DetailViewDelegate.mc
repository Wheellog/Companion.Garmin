using Toybox.WatchUi;

class DetailViewDelegate extends WatchUi.BehaviorDelegate {

    private var view;

    function initialize(_view) {
        BehaviorDelegate.initialize();
        view = _view;
    }

    function onMenu() {
        return true;
    }

    function onPreviousPage() {
        view.moveUp();
        return true;
    }

    function onNextPage() {
        view.moveDown();
        return true;
    }
}