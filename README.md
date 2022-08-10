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

# It Supports
## Custom Block Number
Of course, you can also custom the spacing between blocks.

<img src="https://user-images.githubusercontent.com/78488529/183973081-d743c369-8f61-4c72-a211-b51183bf28f2.JPEG" width="255" height="482"> <img src="https://user-images.githubusercontent.com/78488529/183973087-22c09508-c9d1-4a77-b87c-dfbd4a4ded63.JPEG" width="255" height="482">

## Custom Block Color
Here are examples using **system colors** as below, and you can custom any color you like.

<img src="https://user-images.githubusercontent.com/78488529/183974533-5c3ae4ae-3530-458e-999a-f87a3924b185.JPEG" width="255" height="482"> <img src="https://user-images.githubusercontent.com/78488529/183974538-4e14da58-bb4e-4c6a-9c2b-61aab28d3aef.JPEG" width="255" height="482"> <img src="https://user-images.githubusercontent.com/78488529/183974546-04dd557d-5a59-42fc-bbde-4fbb0b9566ab.JPEG" width="255" height="482">

## Dark mode
Adjust to dark mode color automatically.

<img src="https://user-images.githubusercontent.com/78488529/183975854-60e806c4-5aa8-4adf-8e7c-840fe75c598c.JPEG" width="255" height="482">

# Installation
Require iOS 13, macOS 10.15, watchOS 6 and Xcode 11 or higher.
In Xcode go to `File -> Swift Packages -> Add Package Dependency` 
and paste in the repo's url: 

`https://github.com/VIkill33/SwiftUI-ContributionChart.git`

Or you can download the code of this repo, then `Add Local...` in Xcode, and open the folder of the repo.

# Usage
- Import this package after you've installed by `import ContributionChart`
- Use the chart like
```swift
ContributionChartView(data: yourData,
                      rows: yourRows,
                      columns: yourColumns,
                      targetValue: yourTargetValue,
                      blockColor: .green)
```
Make sure that yourData (**a double array**) you pass has exactly `yourRows * yourColumns` numbers, and the targetValue is recommanded to set to the max value of the array.

The color of a block will appear as exactly the color as parameter `blockColor` when its value is equal to targetValue, and appears light gray when is equal to zero.

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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

```
