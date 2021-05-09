using Toybox.Application;
using Toybox.Application.Properties;
using Toybox.System;

module AppStorage {
    var _showPwmInsteadOfSpeed = null;
    var _appTheme = null;

    var runtimeCache = {};

    function setValue(key, value) {
        switch (key) {
            case :showPwmInsteadOfSpeed: {
                _showPwmInsteadOfSpeed = value;
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
        runtimeCache[key] = value;
    }

    function readFromRuntimeCache(key) {
        return runtimeCache[key];
    }

    function getValue(key) {
        switch (key) {
            case :showPwmInsteadOfSpeed: {
                if (Toybox.Application has :Properties) {
                    if (_showPwmInsteadOfSpeed == null) {
                        _showPwmInsteadOfSpeed = Properties.getValue("ShowPwmInsteadOfSpeed");
                    }
                } else {
                    if (_showPwmInsteadOfSpeed == null) {
                        _showPwmInsteadOfSpeed = Application.getApp().getProperty("ShowPwmInsteadOfSpeed");
                    }
                }
                return _showPwmInsteadOfSpeed;
                break;
            }
            case :appTheme: {
                if (Toybox.Application has :Properties) {
                    if (_appTheme == null) {
                        _appTheme = Properties.getValue("AppTheme");
                    }
                } else {
                    if (_appTheme == null) {
                        _appTheme = Application.getApp().getProperty("AppTheme");
                    }
                }
                return _appTheme;
            }
        }
    }
}