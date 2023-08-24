#!/bin/bash

set -eo pipefail

xcodebuild -archivePath $PWD/build/kehillah.today-ios-swiftui.xcarchive \
            -exportOptionsPlist kehillah.today-ios-swiftui\ iOS/exportOptions.plist \
            -exportPath $PWD/build \
            -allowProvisioningUpdates \
            -exportArchive | xcpretty
