using Toybox.Application;
using Toybox.Application.Properties;
using Toybox.System;

module AppSettings {
    var showPwmInsteadOfSpeed = null;
    var appTheme = null;

    function setValue(key, value) {
        switch (key) {
            case :showPwmInsteadOfSpeed: {
                showPwmInsteadOfSpeed = value;
                if (Toybox.Application has :Properties) {
                    Properties.setValue("ShowPwmInsteadOfSpeed", value);
                } else {
                    Application.getApp().setProperty("ShowPwmInsteadOfSpeed", value);
                }
                break;
            }
            case :appTheme: {
                appTheme = value;
                if (Toybox.Application has :Properties) {
                    Properties.setValue("AppTheme", value);
                } else {
                    Application.getApp().setProperty("AppTheme", value);
                }
                break;
            }
        }
    }

    function getValue(key) {
        switch (key) {
            case :showPwmInsteadOfSpeed: {
                if (Toybox.Application has :Properties) {
                    if (showPwmInsteadOfSpeed == null) {
                        showPwmInsteadOfSpeed = Properties.getValue("ShowPwmInsteadOfSpeed");
                    }
                } else {
                    if (showPwmInsteadOfSpeed == null) {
                        showPwmInsteadOfSpeed = Application.getApp().getProperty("ShowPwmInsteadOfSpeed");
                    }
                }
                return showPwmInsteadOfSpeed;
                break;
            }
            case :appTheme: {
                if (Toybox.Application has :Properties) {
                    if (appTheme == null) {
                        appTheme = Properties.getValue("AppTheme");
                    }
                } else {
                    if (appTheme == null) {
                        appTheme = Application.getApp().getProperty("AppTheme");
                    }
                }
                return appTheme;
            }
        }
    }
}