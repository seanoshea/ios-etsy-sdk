#!/bin/sh

env

xcodebuild -list -project ios-etsy-sdk.xcodeproj

brew update
brew install xctool ios-sim
