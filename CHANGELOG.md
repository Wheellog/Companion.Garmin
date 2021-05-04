# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added:
- Page indicator to details ([#24](https://github.com/Wheellog/WheelLog.Garmin/issues/24))
- Settings, and;
- First option to settings, it will toggle the speed arc data source, whether it will show PWM or speed. Speed number will still show speed

### Changed:
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
