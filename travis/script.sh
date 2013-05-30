#!/bin/sh
set -e

cd bootstrap
xctool -workspace ios-etsy-sdk.xcworkspace -scheme ios-etsy-sdk test
