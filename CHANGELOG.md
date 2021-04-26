# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
- Support for devices `vivoactive 3`, `vivoactive 3 Mercedez-Benz Edition`,`vivoactive 3 Music`, `vivoactive 3 Music LTE`, and `fenix 5s`

### Changed:
- Fixed bug with app crashing when connecting to WheelLog
- Fixed bug with speed number and arcs not updating
- Fixed bugs with some numbers being just too big