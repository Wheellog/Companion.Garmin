import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.System;

module AppStorage {
    var runtimeDb = {};

    function setValue(key, value) {
        if (Toybox.Application has :Properties) {
            Properties.setValue(key, value);
        } else {
            Application.getApp().setProperty(key, value);
        }
    }

    function getValue(key) {
        if (Toybox.Application has :Properties) {
            return Properties.getValue(key);
        } else {
            return Application.getApp().getProperty(key);
        }
    }
}