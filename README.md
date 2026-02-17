# ContributionChart

A contribution chart (aka. heatmap, GitHub-like) library for iOS, macOS, and watchOS.

100% written in SwiftUI.

<img src="https://user-images.githubusercontent.com/78488529/183985880-614250a8-7d9d-4bfe-96b3-08d95d90d6e1.png" width="120" height="150"><img src="https://user-images.githubusercontent.com/78488529/183985888-6724caf4-4f77-4467-9d0b-4e202159ef89.png" width="120" height="150"><img src="https://user-images.githubusercontent.com/78488529/183985895-22ae2cd3-15d7-404f-acd8-2ecee6c74ae3.png" width="120" height="150">

- [It Supports](#it-supports)
  * [Custom Block Number](#custom-block-number)
  * [Custom Block Color](#custom-block-color)
  * [Dark mode](#dark-mode)
- [Installation](#installation)
- [Usage](#usage)
- [Demo Code](#demo-code)
- [Apple Health Examples](#apple-health-examples)
- [iOS 26 Compatibility](#ios-26-compatibility)

Updates
- 2/2026 iOS 18 compatibility: updated minimum platforms (iOS 15+, macOS 12+), replaced deprecated APIs, added privacy manifest, added Apple Health examples.
- 7/31/24 Support input array with any length and add a demo app inside.

# It Supports
## Custom Block Number
Of course, you can also custom the **size** of blocks and **spacing** between blocks.

<img src="https://user-images.githubusercontent.com/78488529/183973081-d743c369-8f61-4c72-a211-b51183bf28f2.JPEG" width="255" height="482"> <img src="https://user-images.githubusercontent.com/78488529/183973087-22c09508-c9d1-4a77-b87c-dfbd4a4ded63.JPEG" width="255" height="482">

## Custom Block Color
Here are examples using **system colors** as below, and you can custom any color you like.

<img src="https://user-images.githubusercontent.com/78488529/183974533-5c3ae4ae-3530-458e-999a-f87a3924b185.JPEG" width="255" height="482"> <img src="https://user-images.githubusercontent.com/78488529/183974538-4e14da58-bb4e-4c6a-9c2b-61aab28d3aef.JPEG" width="255" height="482"> <img src="https://user-images.githubusercontent.com/78488529/183974546-04dd557d-5a59-42fc-bbde-4fbb0b9566ab.JPEG" width="255" height="482">

## Dark mode
Adjust to dark mode color automatically.

<img src="https://user-images.githubusercontent.com/78488529/183975854-60e806c4-5aa8-4adf-8e7c-840fe75c598c.JPEG" width="255" height="482">

# Installation
Requires iOS 15+, macOS 12+, tvOS 15+, watchOS 8+ and Xcode 15 or higher (Swift 5.9+).

In Xcode go to `File -> Add Package Dependencies...`
and paste in the repo's url:

`https://github.com/VIkill33/SwiftUI-ContributionChart.git`

Or you can download the code of this repo, then `Add Local...` in Xcode, and open the folder of the repo.

# Usage
- Import this package after you installed by `import ContributionChart`
- Use the chart like
```swift
ContributionChartView(data: yourData,
                      rows: yourRows,
                      columns: yourColumns,
                      targetValue: yourTargetValue,
                      blockColor: .green)
```
yourData is (**a double array**), and the targetValue is recommanded to set to the max value of the array.

The color of a block will appear as exactly the color as parameter `blockColor` when its value is equal to `targetValue`, and appears light gray when is equal to zero.

The top-Leading block represents the first value in array, while the bottom-trailing represents the last. And the order follows as below:

<img src="https://user-images.githubusercontent.com/78488529/183982320-7c8b9d00-7bfb-4701-b2a6-b371cb9996c2.JPEG" width="255" height="482">

# Demo Code
```swift
import SwiftUI
import ContributionChart

struct ContentView: View {
    var data: [Double]
    let rows = 7
    let columns = 14

    init() {
        data = [0.3, 0.4, 0.4, 0.4, 0.1, 0.5, 0.0, 0.1, 0.0, 0.2, 0.2, 0.2, 0.0, 0.2, 0.2, 0.5, 0.4, 0.2, 0.4, 0.5, 0.2, 0.2, 0.4, 0.3, 0.3, 0.2, 0.4, 0.0, 0.0, 0.5, 0.4, 0.3, 0.5, 0.3, 0.0, 0.0, 0.1, 0.0, 0.2, 0.3, 0.0, 0.0, 0.0, 0.5, 0.3, 0.3, 0.0, 0.3, 0.0, 0.5, 0.3, 0.3, 0.4, 0.5, 0.5, 0.3, 0.4, 0.1, 0.4, 0.2, 0.5, 0.1, 0.4, 0.2, 0.5, 0.4, 0.3, 0.5, 0.0, 0.4, 0.3, 0.2, 0.1, 0.5, 0.2, 0.0, 0.2, 0.5, 0.5, 0.3, 0.4, 0.0, 0.3, 0.3, 0.1, 0.2, 0.5, 0.2, 0.1, 0.4, 0.4, 0.0, 0.5, 0.3, 0.3, 0.5, 0.0, 0.2]
    }

    var body: some View {
        ContributionChartView(data: data,
                              rows: rows,
                              columns: columns,
                              targetValue: 0.5,
                              blockColor: .green)
    }
}

#Preview {
    ContentView()
}
```

# Apple Health Examples

ContributionChart is a great fit for visualizing Apple Health data as heatmaps. Below are complete examples showing how to display daily step counts, workout calories, and sleep hours.

> **Setup required:** Enable the **HealthKit** capability in your Xcode target (Signing & Capabilities), and add `NSHealthShareUsageDescription` to your Info.plist. Authorization is per-type — users can deny individual health data types, so always handle missing data gracefully.

## HealthKitManager

A shared manager used by all examples below:

```swift
import HealthKit

actor HealthKitManager {
    static let shared = HealthKitManager()
    private let store = HKHealthStore()

    var isAvailable: Bool { HKHealthStore.isHealthDataAvailable() }

    func requestAuthorization(read types: Set<HKObjectType>) async throws {
        try await store.requestAuthorization(toShare: [], read: types)
    }

    /// Fetch daily cumulative statistics (e.g. steps, calories) over a date range.
    func dailyStatistics(
        for quantityType: HKQuantityType,
        days: Int,
        unit: HKUnit
    ) async throws -> [Double] {
        let calendar = Calendar.current
        let end = calendar.startOfDay(for: .now)
        let start = calendar.date(byAdding: .day, value: -days, to: end)!
        let interval = DateComponents(day: 1)
        let predicate = HKQuery.predicateForSamples(withStart: start, end: .now)

        return try await withCheckedThrowingContinuation { cont in
            let query = HKStatisticsCollectionQuery(
                quantityType: quantityType,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum,
                anchorDate: start,
                intervalComponents: interval
            )
            query.initialResultsHandler = { _, collection, error in
                if let error { cont.resume(throwing: error); return }
                guard let collection else { cont.resume(returning: []); return }
                var results: [Double] = []
                collection.enumerateStatistics(from: start, to: end) { stats, _ in
                    let value = stats.sumQuantity()?.doubleValue(for: unit) ?? 0
                    results.append(value)
                }
                cont.resume(returning: results)
            }
            self.store.execute(query)
        }
    }

    /// Fetch nightly sleep durations (total asleep time per night).
    func dailySleepHours(days: Int) async throws -> [Double] {
        let calendar = Calendar.current
        let end = calendar.startOfDay(for: .now)
        let start = calendar.date(byAdding: .day, value: -days, to: end)!
        let sleepType = HKCategoryType(.sleepAnalysis)
        let predicate = HKQuery.predicateForSamples(withStart: start, end: .now)

        let samples: [HKCategorySample] = try await withCheckedThrowingContinuation { cont in
            let query = HKSampleQuery(
                sampleType: sleepType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)]
            ) { _, results, error in
                if let error { cont.resume(throwing: error); return }
                cont.resume(returning: (results as? [HKCategorySample]) ?? [])
            }
            self.store.execute(query)
        }

        // Bucket asleep durations by night
        var hoursByDay: [Date: Double] = [:]
        for sample in samples {
            let asleepValues: Set<Int> = [
                HKCategoryValueSleepAnalysis.asleepCore.rawValue,
                HKCategoryValueSleepAnalysis.asleepDeep.rawValue,
                HKCategoryValueSleepAnalysis.asleepREM.rawValue,
            ]
            guard asleepValues.contains(sample.value) else { continue }
            let day = calendar.startOfDay(for: sample.startDate)
            let hours = sample.endDate.timeIntervalSince(sample.startDate) / 3600
            hoursByDay[day, default: 0] += hours
        }

        // Build ordered array
        var results: [Double] = []
        for offset in 0..<days {
            let day = calendar.date(byAdding: .day, value: offset, to: start)!
            results.append(hoursByDay[day] ?? 0)
        }
        return results
    }
}
```

## Example 1: Daily Step Count Heatmap

A 7-row x 4-column grid showing daily steps over 4 weeks. Each block's intensity represents progress toward a 10,000-step goal.

```swift
import SwiftUI
import ContributionChart
import HealthKit

struct StepCountHeatmap: View {
    @State private var stepData: [Double] = []
    private let rows = 7
    private let columns = 4
    private let stepGoal: Double = 10_000

    var body: some View {
        VStack {
            Text("Daily Steps — Past 4 Weeks")
                .font(.headline)
            ContributionChartView(
                data: stepData,
                rows: rows,
                columns: columns,
                targetValue: stepGoal,
                blockColor: .green
            )
            .frame(height: 200)
        }
        .task {
            await loadSteps()
        }
    }

    private func loadSteps() async {
        let manager = HealthKitManager.shared
        guard await manager.isAvailable else { return }
        do {
            try await manager.requestAuthorization(read: [HKQuantityType(.stepCount)])
            stepData = try await manager.dailyStatistics(
                for: HKQuantityType(.stepCount),
                days: rows * columns,
                unit: .count()
            )
        } catch {
            print("Failed to load step data: \(error)")
        }
    }
}
```

## Example 2: Workout Calories Heatmap

A 7-row x 8-column grid showing daily active energy burned over 8 weeks. Uses orange to distinguish from the step chart.

```swift
import SwiftUI
import ContributionChart
import HealthKit

struct CalorieHeatmap: View {
    @State private var calorieData: [Double] = []
    private let rows = 7
    private let columns = 8
    private let calorieGoal: Double = 500 // kcal per day

    var body: some View {
        VStack {
            Text("Active Calories — Past 8 Weeks")
                .font(.headline)
            ContributionChartView(
                data: calorieData,
                rows: rows,
                columns: columns,
                targetValue: calorieGoal,
                blockColor: .orange
            )
            .frame(height: 200)
        }
        .task {
            await loadCalories()
        }
    }

    private func loadCalories() async {
        let manager = HealthKitManager.shared
        guard await manager.isAvailable else { return }
        do {
            try await manager.requestAuthorization(read: [HKQuantityType(.activeEnergyBurned)])
            calorieData = try await manager.dailyStatistics(
                for: HKQuantityType(.activeEnergyBurned),
                days: rows * columns,
                unit: .kilocalorie()
            )
        } catch {
            print("Failed to load calorie data: \(error)")
        }
    }
}
```

## Example 3: Sleep Hours Heatmap

A 7-row x 4-column grid showing nightly sleep duration over 4 weeks. Target is 8 hours per night.

```swift
import SwiftUI
import ContributionChart
import HealthKit

struct SleepHeatmap: View {
    @State private var sleepData: [Double] = []
    private let rows = 7
    private let columns = 4
    private let sleepGoal: Double = 8.0 // hours

    var body: some View {
        VStack {
            Text("Sleep — Past 4 Weeks")
                .font(.headline)
            ContributionChartView(
                data: sleepData,
                rows: rows,
                columns: columns,
                targetValue: sleepGoal,
                blockColor: .indigo
            )
            .frame(height: 200)
        }
        .task {
            await loadSleep()
        }
    }

    private func loadSleep() async {
        let manager = HealthKitManager.shared
        guard await manager.isAvailable else { return }
        do {
            try await manager.requestAuthorization(read: [HKCategoryType(.sleepAnalysis)])
            sleepData = try await manager.dailySleepHours(days: rows * columns)
        } catch {
            print("Failed to load sleep data: \(error)")
        }
    }
}
```

### Notes on Apple Health Integration
- In user-facing UI, say **"Apple Health"** — never "HealthKit."
- Authorization is per-type. Users can grant steps but deny sleep. Design your app to show an empty or placeholder chart for denied types.
- Never store health data in iCloud. Store locally only.
- Never write sample/test data to Apple Health. Use mock data arrays for previews and testing.
- Prefer `HKStatisticsCollectionQuery` for time-bucketed data — never manually bucket raw samples.

# iOS 26 Compatibility

iOS 26 introduces **Liquid Glass**, a translucent material system for UI chrome. Standard SwiftUI components (`NavigationStack`, `TabView`, `Toolbar`) adopt glass automatically when recompiled with Xcode 26 SDK — no code changes needed.

**Important for ContributionChart users:**
- The chart itself should **not** use `.glassEffect()`. Charts and data visualizations are content, not chrome — they must remain on the opaque content layer for readability.
- Container views around the chart (cards, panels) may use `.glassEffect()` if desired, but test readability with varied wallpapers.
- Full Liquid Glass rendering requires A17 Pro or later (iPhone 15 Pro+, M-series iPads). Older devices fall back to a `.ultraThinMaterial` appearance.
