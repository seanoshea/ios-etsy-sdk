#!/bin/sh
set -e

xctool -workspace bootstrap/ios-etsy-sdk.xcworkspace -scheme ios-etsy-sdk test
