#!/bin/bash

set -eo pipefail

xcodebuild -project kehillah.today-ios-swiftui.xcodeproj \
            -target kehillah.today-ios-swiftui \
            -sdk iphoneos \
            -configuration AppStoreDistribution \
            -archivePath $PWD/build/kehillah.today-ios-swiftui.xcarchive \
            clean archive | xcpretty
