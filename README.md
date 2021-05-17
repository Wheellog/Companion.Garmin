# ⌚️ Companion.Garmin 

A WheelLog companion for Garmin smartwatches

This app is a rebuild from ground-up of an original Garmin app. I made this app to be with better UI, alarms working, and full support of new watches and their features.

[Download from Garmin ConnectIQ Store](https://apps.garmin.com/en-US/apps/35719a02-8a5d-46bc-b474-f26c54c4e045)
## 🔤 Important

License: **GPLv3**

Changelog: [here](https://github.com/Wheellog/Companion.Garmin/blob/master/CHANGELOG.md)

## 🏞 Screenshots
![screenshot 1](https://raw.githubusercontent.com/Wheellog/Companion.Garmin/master/.github/readme-images/1.png)
![screenshot 2](https://raw.githubusercontent.com/Wheellog/Companion.Garmin/master/.github/readme-images/2.png)
![screenshot 3](https://raw.githubusercontent.com/Wheellog/Companion.Garmin/master/.github/readme-images/3.png)
![screenshot 4](https://raw.githubusercontent.com/Wheellog/Companion.Garmin/master/.github/readme-images/4.png)

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
