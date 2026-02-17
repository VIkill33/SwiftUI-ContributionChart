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

## QuickStart — Integrating into an iOS App

1. In Xcode: `File -> Add Package Dependencies...` -> paste `https://github.com/VIkill33/SwiftUI-ContributionChart.git`
2. `import ContributionChart` in your SwiftUI view file
3. Add the view:
```swift
ContributionChartView(
    data: [Double],        // your values (auto-pads if shorter than rows*columns)
    rows: Int,             // blocks per column
    columns: Int,          // number of columns
    targetValue: Double,   // value for full color intensity
    blockColor: .green     // default; any Color works
)
```

### Optional parameters
| Parameter | Default | Description |
|-----------|---------|-------------|
| `blockBackgroundColor` | System background | Omit to use platform default |
| `RectangleWidth` | `20.0` | Block size in points |
| `RectangleSpacing` | `2.0` | Gap between blocks |
| `RectangleRadius` | `5.0` | Corner radius |

### Customization tips
- **Block size:** `RectangleWidth` — use ~20 for 4-week views, ~10 for 6-month, ~6 for yearly
- **Circles:** Set `RectangleRadius` to half of `RectangleWidth`
- **Square corners:** `RectangleRadius: 0`
- **Dense grids:** Reduce `RectangleSpacing` to 1 for large time ranges
- **Time range picker:** Use a `TimeRange` enum mapping `.month`/`.quarter`/`.halfYear`/`.year` to different `rows`, `columns`, and block sizes — see README for full example

### Connecting data sources
- **Static data:** Pass any `[Double]` array directly
- **Core Data / REST API:** Fetch in `.task { }` or `.onAppear { }`, store in `@State`, pass to chart
- **Apple Health:** Use `HKStatisticsCollectionQuery` for daily aggregation — see README for full examples

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
