#!/bin/sh
set -e

pod install --no-integrate
xctool -project ios-etsy-sdk.xcodeproj -scheme ios-etsy-sdk build test
