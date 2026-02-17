# CLAUDE.md - Project Guide

## Overview
SwiftUI contribution chart (heatmap) library for iOS, macOS, tvOS, and watchOS. Pure SwiftUI, no external dependencies.

## Build & Test

### Library (Swift Package)
```bash
swift build
swift test
```

### DemoApp
Open `DemoApp/DemoApp/DemoApp.xcodeproj` in Xcode. The DemoApp references the local package via relative path.

## Platform Requirements
- iOS 15.0+
- macOS 12.0+
- tvOS 15.0+
- watchOS 8.0+
- Swift tools version: 5.9

## Code Conventions
- Use `foregroundStyle(_:)` — never the deprecated `foregroundColor(_:)`
- Use `#Preview` macro — never the deprecated `PreviewProvider`
- No `print()` statements in library code
- All public API types use `@available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)` annotations
- Pure SwiftUI — no UIKit/AppKit view wrappers in the library

## File Structure
- `Sources/ContributionChart/ContributionChartView.swift` — Main public view, internal row view, Color extension
- `Sources/ContributionChart/ContributionChartTest.swift` — Preview/test view (not public API)
- `Sources/ContributionChart/PrivacyInfo.xcprivacy` — Privacy manifest
- `DemoApp/` — Example iOS app
- `Package.swift` — SPM manifest

## iOS 26 / Liquid Glass
The chart renders on the opaque content layer — it is data, not chrome. Never apply `.glassEffect()` to charts or data visualizations. Glass is only for navigation bars, tab bars, toolbars, and controls.
