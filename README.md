# WheelLog.Garmin

A WheelLog app for Garmin smartwatches

This app is a rebuild from ground-up of an original Garmin app. I made this app to be with better UI, more options, and also settings sync from WheelLog app.

Btw here is the original app repository on [GitHub](https://github.com/marccardinal/WheelLog-Garmin-ConnectIQ).

## Contributing

To contribute, fork this repo, add changes you want, and create a pull request. I'll review it and merge it if possible :D

## Screenshots
![screenshot 1](https://raw.githubusercontent.com/GGorAA/WheelLog.Garmin/master/screenshots/screenshot%201.jpg)

## Development/building

To build the app, go to properties.mk and set path to the developer key. After that, you can just run `make build` to build the app. To run it in a simulator, run `make run`. There is also a command called `make rerun`, which is not waiting for a simulator to start, but only runs the app in a simulator. You can also build for every device using `make buildall`, and you will have a binary for every device in `bin` folder. For publishing to the Connect IQ Store, use `make package`. And lastly, to clean, use `make clean`.

## Translations

You can contribute to translations here: https://poeditor.com/join/project?hash=WUAV6h3bxB
