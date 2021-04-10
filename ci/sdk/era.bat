@echo off
java -cp "%~dp0era.jar"; com.garmin.connectiq.era.cli.EraDownloader %*
