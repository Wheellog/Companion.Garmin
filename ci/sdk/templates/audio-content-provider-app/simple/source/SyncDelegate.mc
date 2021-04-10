using Toybox.Communications;
using Toybox.Media;

class ${syncDelegateClassName} extends Media.SyncDelegate {

    function initialize() {
        SyncDelegate.initialize();
    }

    // Called when the system starts a sync of the app.
    // The app should begin to download songs chosen in the configure
    // sync view .
    function onStartSync() {
        Media.notifySyncComplete(null);
    }

    // Called by the system to determine if the app needs to be synced.
    function isSyncNeeded() {
        return false;
    }

    // Called when the user chooses to cancel an active sync.
    function onStopSync() {
        Communications.cancelAllRequests();
        Media.notifySyncComplete(null);
    }
}
