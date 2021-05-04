using Toybox.Application;
using Toybox.Application.Properties;
using Toybox.System;

module AppSettings {
    var showPwmInsteadOfSpeed = false;

    function setValue(key, value) {
        switch (key) {
            case :showPwmInsteadOfSpeed: {
                showPwmInsteadOfSpeed = value;
                if (Toybox.Application has :Storage) {
                    Properties.setValue("showPwmInsteadOfSpeed", value);
                } else {
                    Application.getApp().setProperty("showPwmInsteadOfSpeed", value);
                }
                break;
            }
        }
    }

    function getValue(key) {
        switch (key) {
            case :showPwmInsteadOfSpeed: {
                if (Toybox.Application has :Properties) {
                    showPwmInsteadOfSpeed = Properties.getValue("showPwmInsteadOfSpeed");
                } else {
                    showPwmInsteadOfSpeed = Application.getApp().getProperty("showPwmInsteadOfSpeed");
                }
                return showPwmInsteadOfSpeed;
                break;
            }
        }
    }
}