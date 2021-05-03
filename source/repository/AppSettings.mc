using Toybox.Application;
using Toybox.Application.Storage;
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
                    Storage.setValue("showPwmInsteadOfSpeed", value);
                } else {
                    System.println("AppBase");
                    Application.getApp().setProperty("showPwmInsteadOfSpeed", value);
                }
            }
        }
    }
}