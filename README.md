# WheelLog.Garmin

A WheelLog app for Garmin smartwatches

This app is a rebuild from ground-up of an original Garmin app. I made this app to be with better UI, more options, and also settings sync from WheelLog app.

## Contributing

To contribute, fork this repo, add changes you want, and create a pull request. I'll review it and merge it if possible :D

## Development/building

To build the app, go to properties.mk and set path to the developer key. After that, you can just run `make build` to build the app. To run it in a simulator, run `make run`. You can also build for every device using `make buildall`, and you will have a binary for every device in `bin` folder. For publishing to the Connect IQ Store, use `make package`. And lastly, to clean, use `make clean`.

## Translations

I will later add a possibility to contribute to translations, so for now you need to directly fork a repo and edit strings.xml file for your desired language.