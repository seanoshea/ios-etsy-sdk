#!/bin/sh
set -e

xctool -project bootstrap/ios-etsy-sdk.xcworkspace -scheme ios-etsy-sdk test
