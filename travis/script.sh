#!/bin/sh
set -e

ls Pods
xctool -project ios-etsy-sdk.xcodeproj -scheme ios-etsy-sdk build test
