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
                    Properties.setValue("ShowPwmInsteadOfSpeed", value);
                } else {
                    Application.getApp().setProperty("ShowPwmInsteadOfSpeed", value);
                }
                break;
            }
        }
    }

    function getValue(key) {
        switch (key) {
            case :showPwmInsteadOfSpeed: {
                if (Toybox.Application has :Properties) {
                    showPwmInsteadOfSpeed = Properties.getValue("ShowPwmInsteadOfSpeed");
                } else {
                    showPwmInsteadOfSpeed = Application.getApp().getProperty("ShowPwmInsteadOfSpeed");
                }
                return showPwmInsteadOfSpeed;
                break;
            }
        }
    }
}