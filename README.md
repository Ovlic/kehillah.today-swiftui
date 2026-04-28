# Kehillah.Today (iOS)

[![App Store](https://img.shields.io/badge/App%20Store-Download-blue?logo=apple)](https://apps.apple.com/app/id6443492717)
![iOS](https://img.shields.io/badge/iOS-15.5%2B-black?logo=apple)
![Swift](https://img.shields.io/badge/Swift-5-orange?logo=swift)

Available on the App Store:  
https://apps.apple.com/app/id6443492717

An iOS app built with SwiftUI that provides access to the Kehillah schedule and announcements through a mobile-optimized interface.

The app uses a native SwiftUI shell combined with a `WKWebView` to render a bundled HTML/JavaScript application, with additional features and data handling that go beyond the main website.

---

## Overview

This app is a hybrid iOS application:

* Native SwiftUI handles:

  * App lifecycle
  * Launch screen
  * WebView container
  * System integrations (dark mode, persistence)

* A bundled HTML/JavaScript app (`kt_mobile.html`) handles:

  * Schedule rendering
  * UI and interaction logic

### Key distinction

While based on the [Kehillah Today website](https://kehillah.today), this app is not just a wrapper. It includes:

* Additional features not present on the site
* A separate announcements system
* A more flexible schedule data model

---

## Features

* Daily schedule view
* Current time and current block tracking
* Tomorrow’s schedule preview
* Announcements (handled independently from the website)
* Special schedule support
* Calendar event headers for days with no special schedule
* User settings (stored locally):

  * Rename blocks
  * Toggle passing periods
  * Color preferences
  * Dark mode
* Fast and lightweight

---

## Architecture

```text
SwiftUI App
  → PreLaunch (splash)
  → ContentView
  → MainPage
  → WebView (WKWebView wrapper)
  → kt_mobile.html (bundled web app)
```

### Key Components

* `SwiftUIWebView.swift` — WKWebView bridge
* `WebView.swift` — container and configuration
* `LocalWebViewVM.swift` — loads local HTML content
* `PreLaunch.swift` — splash screen
* `MainPage.swift` — main UI entry point

---

## Data & Logic

* Core UI and logic are handled in `kt_mobile.html`
* Schedule data is loaded from a modified mirror of the [main website’s schedule API](https://github.com/braxtongill/kehillah.today/blob/main/dates.js), allowing for:

  * More flexible data structures
  * Additional fields (e.g. calendar event headers)

* The app supports:

  * Standard schedules
  * Special schedules
  * Date-specific overrides (text without full schedule changes)

Announcements are handled through a separate, dynamic data pipeline:

* A custom announcements feed is maintained independently of the main website 
  * *(currently private, planned for future release)*
* Unlike the original site (which used hardcoded announcements), this system is fully dynamic and can be updated without modifying frontend code
* The schema differs from the official site, enabling more flexible formatting and app-specific features

---

## Getting Started

### Requirements

* Xcode (latest recommended)
* iOS 16+ (or your deployment target)

### Setup

```bash
git clone https://github.com/Ovlic/kehillah.today-swiftui.git
cd kehillah.today-swiftui
open kehillah.today-ios-swiftui.xcodeproj
```

Build and run in Xcode.


## Notes

* The majority of app logic lives in the HTML/JavaScript layer
* The app is partially independent from the main website and may include features not present there
* `Old HTML/` contains legacy/test files and is not used
* `.github/workflows/` exists but is not currently active
* The folders are named `kehillah.today-ios-swiftui`, contradicting the repository name of `kehillah.today-swiftui`. This is due to earlier project naming and has been kept to avoid breaking Xcode project references.
* `kehillah.today-ios-watchos Watch App` is a placeholder for a future watchOS version and is not currently functional (and probably won't be for a while since I didn't know what I was getting into when I created it)

## Contributions

Feel free to fork and improve the project.
