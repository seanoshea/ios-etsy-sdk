#!/bin/sh

env

pod install --no-integrate

xcodebuild -list -project ios-etsy-sdk.xcodeproj

brew update
brew install xctool ios-sim
