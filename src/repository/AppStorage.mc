using Toybox.Application;
using Toybox.Application.Properties;
using Toybox.System;

module AppStorage {
    var cachedValues = {};

    var runtimeDb = {};

    function setValue(key, value) {
        cachedValues[key] = value;
        if (Toybox.Application has :Properties) {
            Properties.setValue(key, value);
        } else {
            Application.getApp().setProperty(key, value);
        }
    }

    function getValue(key) {
        if (Toybox.Application has :Properties) {
            if (cachedValues[key] == null) {
                cachedValues[key] = Properties.getValue(key);
            }
        } else {
            if (cachedValues[key] == null) {
                cachedValues[key] = Application.getApp().getProperty(key);
            }
        }
        return cachedValues[key];
    }
}