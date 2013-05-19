#!/bin/sh

env

xcodebuild -list -workspace ios-etsy-sdk.xcodeproj

brew update
brew install xctool ios-sim
