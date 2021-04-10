using Toybox.Media;

class ${contentIteratorClassName} extends Media.ContentIterator {

    function initialize() {
        ContentIterator.initialize();
    }

    // Determine if the the current track can be skipped.
    function canSkip() {
        return false;
    }

    // Get the current media content object.
    function get() {
        return null;
    }

    // Get the current media content playback profile
    function getPlaybackProfile() {
        var profile = new Media.PlaybackProfile();
        profile.attemptSkipAfterThumbsDown = false;
        profile.playbackControls = [
            PLAYBACK_CONTROL_SKIP_BACKWARD,
            PLAYBACK_CONTROL_PLAY,
            PLAYBACK_CONTROL_SKIP_FORWARD
        ];
        profile.playbackNotificationThreshold = 1;
        profile.requirePlaybackNotification = false;
        profile.skipPreviousThreshold = null;
        profile.supportsPlaylistPreview = false;
        return profile;
    }

    // Get the next media content object.
    function next() {
        return null;
    }

    // Get the next media content object without incrementing the iterator.
    function peekNext() {
        return null;
    }

    // Get the previous media content object without decrementing the iterator.
    function peekPrevious() {
        return null;
    }

    // Get the previous media content object.
    function previous() {
        return null;
    }

    // Determine if playback is currently set to shuffle.
    function shuffling() {
        return false;
    }

}
