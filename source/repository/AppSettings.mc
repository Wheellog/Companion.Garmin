using Toybox.Application;
using Toybox.Application.Properties;
using Toybox.System;

module AppSettings {
    var showPwmInsteadOfSpeed = false;

    function setValue(key, value) {
        switch (key) {
            case :showPwmInsteadOfSpeed: {
                showPwmInsteadOfSpeed = value;
                System.println(value);
                if (Toybox.Application has :Storage) {
                    System.println("Storage");
                    Properties.setValue("showPwmInsteadOfSpeed", value);
                } else {
                    System.println("AppBase");
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
                    System.println("Has properties");
                    showPwmInsteadOfSpeed = Properties.getValue("showPwmInsteadOfSpeed");
                } else {
                    System.println("no properties");
                    showPwmInsteadOfSpeed = Application.getApp().getProperty("showPwmInsteadOfSpeed");
                }
                return showPwmInsteadOfSpeed;
                break;
            }
        }
    }
}