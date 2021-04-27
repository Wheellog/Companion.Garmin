# ⌚️ Companion.Garmin 

A WheelLog companion for Garmin smartwatches

This app is a rebuild from ground-up of an original Garmin app. I made this app to be with better UI, alarms working, and full support of new devices and their features.

Btw here is the original app repository on [GitHub](https://github.com/marccardinal/WheelLog-Garmin-ConnectIQ).

Also here is my [fork of WheelLog](https://github.com/GGorAA/WheelLog.Android), which works with this companion.

## 🏞 Screenshots
![screenshot 1](https://raw.githubusercontent.com/GGorAA/WheelLog.Garmin/master/screenshots/screenshot%201.jpg)

## 🛠 Development/Building

**Note:** Make commands are made to work with macOS, because that's where i develop 🤷 But it should work on other Unix systems like Linux. Sorry Windows users, something will not work here 🤷

Here is the list of every `make` target that you can use:

`build` - I think you know what it does

`buildall` - Builds for every device listed in manifest

`run` - Builds, and then runs the app in a simulator

`rerun` - Reruns the app in a simulator, when the former is already launched

`deploy` - Builds, and dhen deploys the app to a physical device. For this you need to connect your watch to your computer using a USB cable, and set `USB Mode` (it is in Settings > System, and then scroll down to find it), to `Storage`

`check-deployment` - Checks if the app is deployed to the end device. Basically calls `check-deployment.sh` under `makescripts` dir.

`package` - Packages a `.iq` file ready to be uploaded to Garmin ConnectIQ Store

`clean` - Also understandable, deleted `bin` directory

`clean-xml` - This target removes all `.xml` files under a `bin` directory

`generate-devkey` - Generates a developer key, that is pretty much used in every place of making a ConnectIQ app. You should also point to that key in `properties.mk`

## 🌍 Translations

You can contribute to translations here: https://poeditor.com/join/project?hash=WUAV6h3bxB
