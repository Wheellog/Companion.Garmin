using Toybox.Application;
using Toybox.Application.Properties;
using Toybox.System;

module AppStorage {
    var showPwmInsteadOfSpeed = null;
    var appTheme = null;

    var _runtimeCache = {};

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
                _appTheme = value;
                if (Toybox.Application has :Properties) {
                    Properties.setValue("AppTheme", value);
                } else {
                    Application.getApp().setProperty("AppTheme", value);
                }
                break;
            }
        }
    }

    function writeToRuntimeCache(key, value) {
        _runtimeCache[key] = value;
    }

    function readFromRuntimeCache(key) {
        return _runtimeCacne[key];
    }

    function getValue(key) {
        switch (key) {
            case :showPwmInsteadOfSpeed: {
                if (Toybox.Application has :Properties) {
                    if (showPwmInsteadOfSpeed == null) {
                        _showPwmInsteadOfSpeed = Properties.getValue("ShowPwmInsteadOfSpeed");
                    }
                } else {
                    if (showPwmInsteadOfSpeed == null) {
                        _showPwmInsteadOfSpeed = Application.getApp().getProperty("ShowPwmInsteadOfSpeed");
                    }
                }
                return showPwmInsteadOfSpeed;
                break;
            }
            case :appTheme: {
                if (Toybox.Application has :Properties) {
                    if (appTheme == null) {
                        _appTheme = Properties.getValue("AppTheme");
                    }
                } else {
                    if (appTheme == null) {
                        _appTheme = Application.getApp().getProperty("AppTheme");
                    }
                }
                return appTheme;
            }
        }
    }
}