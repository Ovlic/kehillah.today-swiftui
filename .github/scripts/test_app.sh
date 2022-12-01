#!/bin/bash

set -eo pipefail

xcodebuild -project kehillah.today-ios-swiftui.xcodeproj \
            -target kehillah.today-ios-swiftui \
            -destination platform=iOS\ Simulator,OS=15.5,name=iPhone\ 13 \
            clean test | xcpretty
