using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;

class DetailView extends WatchUi.View {

    private var currentlyOnScreen = 0;
    private var maxScreens = 3;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.DetailsLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {

    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {

    }

    function moveUp() {
        if (currentlyOnScreen == 0) {
            WatchUi.switchToView(new HomeView(), new HomeViewDelegate(), WatchUi.SLIDE_DOWN);
        } else {
            currentlyOnScreen--;
            WatchUi.requestUpdate();
        }
    }

    function moveDown() {
        if (currentlyOnScreen + 1 != maxScreens) {
            currentlyOnScreen++;
            WatchUi.requestUpdate();
        }
    }
}