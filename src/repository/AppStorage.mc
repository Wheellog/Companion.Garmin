import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.System;

module AppStorage {
    var runtimeDb = {};

    function setSetting(key, value) {
        if (Toybox.Application has :Properties) {
            Properties.setValue(key, value);
        } else {
            Application.getApp().setProperty(key, value);
        }
    }

    function getSetting(key) {
        if (Toybox.Application has :Properties) {
            return Properties.getValue(key);
        } else {
            return Application.getApp().getProperty(key);
        }
    }
}