#!/bin/sh
set -e

# xcodebuild -project bootstrap/Pods/Pods.xcodeproj -target Pods-ios-etsy-sdkTests -sdk iphonesimulator6.1 -configuration Debug -arch i386
xctool -workspace bootstrap/ios-etsy-sdk.xcworkspace -scheme ios-etsy-sdk -sdk iphonesimulator6.1 -configuration Debug -arch i386 test
