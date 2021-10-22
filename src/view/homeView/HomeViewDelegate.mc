import Toybox.WatchUi;
import Toybox.System;

class HomeViewDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        if (Toybox.WatchUi has :Menu2) {
            var menu = new WatchUi.Menu2({
                :title => Rez.Strings.MainMenu_Title
            });
            
            var appThemeValue;
            if (AppStorage.getSetting("AppTheme") == 0){
                appThemeValue = false;
            } else {
                appThemeValue = true;
            }
            var appThemSubLabel;
            if (AppStorage.getSetting("AppTheme") == 0){
                appThemSubLabel = Rez.Strings.MainMenu_AppTheme_Light;
            } else {
                appThemSubLabel = Rez.Strings.MainMenu_AppTheme_Dark;
            }
            menu.addItem(new WatchUi.MenuItem(
                Rez.Strings.MainMenu_AppTheme,
                appThemSubLabel,
                "AppTheme",
                null
            ));
            var dataUpdateSpeedSublabel;
            switch (AppStorage.getSetting("DataUpdateSpeed")) {
                case 400: dataUpdateSpeedSublabel = WatchUi.loadResource(Rez.Strings.MainMenu_DataUpdateSpeed_Fast); break;
                case 1000: dataUpdateSpeedSublabel = WatchUi.loadResource(Rez.Strings.MainMenu_DataUpdateSpeed_Medium); break;
                case 1500: dataUpdateSpeedSublabel = WatchUi.loadResource(Rez.Strings.MainMenu_DataUpdateSpeed_Slow); break;
                case 2000: dataUpdateSpeedSublabel = WatchUi.loadResource(Rez.Strings.MainMenu_DataUpdateSpeed_SuperSlow); break;
            }
            menu.addItem(new WatchUi.MenuItem(
                Rez.Strings.MainMenu_DataUpdateSpeed,
                dataUpdateSpeedSublabel,
                "DataUpdateSpeed",
                null
            ));
            var startButtonActionSubLabel;
            switch (AppStorage.getSetting("StartButtonAction")) {
                case 0: startButtonActionSubLabel = WatchUi.loadResource(Rez.Strings.MainMenu_StartButtonAction_HornTrigger); break;
                case 1: startButtonActionSubLabel = WatchUi.loadResource(Rez.Strings.MainMenu_StartButtonAction_FrontLightToggle); break;
            }
            if (AppStorage.runtimeDb["comm_protocolVersion"] > 2) {
                menu.addItem(new WatchUi.MenuItem(
                    Rez.Strings.MainMenu_StartButtonAction,
                    startButtonActionSubLabel,
                    "StartButtonAction",
                    null
                ));
            }
            WatchUi.pushView(menu, new SettingsMenu2Delegate(), WatchUi.SLIDE_UP);
        } else {
            var menu = new WatchUi.Menu();
            menu.setTitle(Rez.Strings.MainMenu_Title);
            menu.addItem(Rez.Strings.MainMenu_AppTheme, :AppTheme);
            menu.addItem(Rez.Strings.MainMenu_DataUpdateSpeed, :DataUpdateSpeed);
            if (AppStorage.runtimeDb["comm_protocolVersion"] > 2) {
                menu.addItem(Rez.Strings.MainMenu_StartButtonAction, :StartButtonAction);
            }

            WatchUi.pushView(menu, new SettingsMenuDelegate(), WatchUi.SLIDE_UP);
        }
        return true;
    }

    function onSelect() {
        switch (AppStorage.getSetting("StartButtonAction")) {
            case 0: Actions.triggerHorn(); break;
            case 1: if (AppStorage.runtimeDb["comm_protocolVersion"] > 2) { Actions.toggleFrontLight(); } else { Actions.triggerHorn(); } break;
        }
        return true;
    }

    function onNextPage() {
        updateIndexManifest(generateIndexManifest(:detailScreenData)); // Update manifest
        var view = new DetailView();
        WatchUi.switchToView(view, new DetailViewDelegate(view), WatchUi.SLIDE_UP); // Switch to DetailView
        return true;
    }
}