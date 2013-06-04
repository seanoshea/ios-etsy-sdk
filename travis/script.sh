#!/bin/sh
set -e

xctool -workspace bootstrap/ios-etsy-sdk.xcworkspace -scheme ios-etsy-sdk -sdk iphonesimulator6.1 -configuration Debug -arch "i386" clean test
