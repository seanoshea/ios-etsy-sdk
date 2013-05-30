#!/bin/sh

env

xcodebuild -list -project bootstrap/ios-etsy-sdk.xcodeproj

brew update
brew install xctool ios-sim
