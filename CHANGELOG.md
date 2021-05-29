# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [[2.2 Stable] - 29.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/2.2)

### Added:
- Translations for Ukrainian language.

---

## [[2.1.1 Stable] - 28.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/2.1.1)

### Changed:
- Fixed data update speed menu item not showing up on devices powered by CIQ 3.0+, like fenix 6 and forerunner 945.

---

## [[2.1 Stable] - 28.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/2.1)

### Added:
- An option to change communication speed. Will be very useful in cases when there are a ton of
devices connected to Bluetooth at the same time
- Support for:
    - Approach S60
    - Approach S62
    - MARQ Adventurer
    - MARQ Athlete
    - MARQ Aviator
    - MARQ Commander
    - MARQ Driver
    - MARQ Expedition
    - MARQ Golfer
- Autoreconnect. When the app disconnects from WheelLog, it will try to connect back with last know connection credentials.

### Changed:
- Scrolling, now it wraps around, like is menus
- Failed attempts in a row before disconnection from 4 to 10. In English, it means that it will
take longer to disconnect, and the app will try more times to connect back

---

## [[2.0.6 Stable] - 21.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/2.0.6)

### Added:
- Support for:
    - Enduro
    - Forerunner 645
    - Forerunner 645 Music
    - Forerunner 935

---

## [[2.0.5 Stable] - 18.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/2.0.5)

### Changes:
- Fixed issues on devices powered by CIQ 4.0.0

---


## [[2.0.4 Stable] - 13.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/2.0.4)

### Changes:
- Fixed crashes on vivoactive watches

---

## [[2.0.2 Stable] - 13.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/2.0.2)

### Changes:
- Fixed issues with settings menu on the watch

---

## [[2.0.1 Stable] - 13.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/2.0.1)

### Changed:
- Fixed issues with coloring of speed arc

---

## [[2.0 Stable] - 13.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/2.0)

### Added
- Support for Forerunner 945
- Tone on connection/disconnection of the app
- Tone on connection/disconnection of the wheel
- Tone on low battery of the wheel, exactly when it is lower 20%
- Functionality, that brings the connection waiting view back on the screen if the app failed to get new data in span of 2 seconds
- Speed dial color will change to orange on 70 to 90 PWM, and to red after 90 PWM
- A Connection successful! screen, which will be shown after connection with the app

### Changed:
- Page indicator in details, moved back to the left and;
- Redesigned the page indicator, now it is smaller, and looks more like native one
- Redesigned the details view, according to [this change in WheelLog.Android](https://github.com/Wheellog/Wheellog.Android/pull/193)
- Updated communication

---

## [[1.2.3 Stable] - 08.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/1.2.3)

### Changed:
- Moved the page indicator to the right ([#46](https://github.com/Wheellog/WheelLog.Garmin/issues/46))
- Optimized rendering

---

## [[1.2.2 Stable] - 07.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/1.2.2)

### Changed:
- Fixed [#48](https://github.com/Wheellog/WheelLog.Garmin/issues/48)
- Fixed some strings not being translated

---

## [[1.2.1 Stable] - 07.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/1.2.1)

### Changed:
- Fixed [#43](https://github.com/Wheellog/WheelLog.Garmin/issues/43)

---

## [[1.2.0 Stable] - 07.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/1.2.0)

### Changed:
- Communication system
---

## [[1.1.0 Stable] - 07.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/1.1.0)

### Added:
- White theme to the home view

### Changed:
- Fixed issues with some strings not being translated

---

## [[1.0.0 Stable] - 04.05.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/1.0.0)

### Added:
- Page indicator to details ([#24](https://github.com/Wheellog/WheelLog.Garmin/issues/24))
- Settings menu, and;
- First option to settings, it will toggle the speed arc data source, whether it will show PWM or speed. Speed number will still show speed

### Changed:
- Arc position, now the bottom parts are symmetrical, like in WheelLog.Android
- Font in speed, battery, and temperature numbers, also bottom subtitle text to Prime font, used in WheelLog.Android
- Fixed [#37](https://github.com/Wheellog/WheelLog.Garmin/issues/37)
- Fixed [#34](https://github.com/Wheellog/WheelLog.Garmin/issues/34)
- Fixed [#18](https://github.com/Wheellog/WheelLog.Garmin/issues/18)

---

## [[1.0.0 Beta 5] - 30.04.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/1.0.0-beta5)

### Added:
- Horn support. You can click on Start button on button-controlled smartwatches, or tap on the screen on touch-controller smartwatches, to trigger the horn. 
- Alarm support. It will vibrate when any alarm is executed

### Changed:
- Fixed [#20](https://github.com/Wheellog/WheelLog.Garmin/issues/20)
- Fixed issues in communication with WheelLog
- Fixed [#7](https://github.com/Wheellog/WheelLog.Garmin/issues/7)

--- 

## [[1.0.0 Beta 4] - 19.04.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/1.0.0-beta4)

### Added:
- Support for vívoactive 4 ([#9](https://github.com/Wheellog/WheelLog.Garmin/issues/9))
- Support for vívoactive 4s ([#9](https://github.com/Wheellog/WheelLog.Garmin/issues/9))
- Support for fēnix chronos ([#15](https://github.com/Wheellog/WheelLog.Garmin/issues/15))

### Changed:
- Filter in mailHandler, so it now can handle messages that just consist of a port number
- Main app class, now it is called WheelLogCompanionApp

---

## [[1.0.0 Beta 3] - 19.04.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/1.0.0-beta3)

### Changed:
- Replaced mailbox communication with web server communication ([#6](https://github.com/Wheellog/WheelLog.Garmin/issues/6))
- Fixed a bug with app crashing when entering third screen in details view ([#5](https://github.com/Wheellog/WheelLog.Garmin/issues/5))
- Fixed a bug with arcs on the home screen not updating ([#7](https://github.com/Wheellog/WheelLog.Garmin/issues/7))

---

## [[1.0.0 Beta 2] - 12.04.2021](https://github.com/Wheellog/WheelLog.Garmin/releases/tag/1.0.0-beta2)

### Added: 
- Support for devices vívoactive 3, vívoactive 3 Mercedez-Benz Edition,vívoactive 3 Music, vívoactive 3 Music LTE, and fēnix 5s

### Changed:
- Fixed bug with app crashing when connecting to WheelLog
- Fixed bug with speed number and arcs not updating
- Fixed bugs with some numbers being just too big
