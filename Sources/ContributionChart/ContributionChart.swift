import SwiftUI
import UIKit

@available(*, deprecated, renamed: "IrregularGradient")
struct ContributionChartView: View {
    
    var data: [Double]
    var rows: Int
    var columns: Int
    var targetValue: Double
    var heatMapRectangleWidth: Double = 20.0
    var heatMapRectangleSpacing: Double = 2.0
    var body: some View {
        HStack(spacing: heatMapRectangleSpacing) {
            ForEach(0..<columns) { i in
                let start = i * rows
                let end = (i + 1) * rows
                let splitedData = Array(data[start..<end])
                HeatMapRowView(rowData: splitedData,
                               rows: rows,
                               targetValue: targetValue,
                               heatMapRectangleWidth: heatMapRectangleWidth,
                               heatMapRectangleSpacing: heatMapRectangleSpacing
                )
            }
        }
        .padding()
    }
}

struct HeatMapRowView: View {
    
    var rowData: [Double]
    var rows: Int
    var targetValue: Double
    
    var heatMapRectangleWidth: Double
    var heatMapRectangleSpacing: Double
    var body: some View {
        VStack(spacing: heatMapRectangleSpacing) {
            ForEach(0..<rows) { index in
                let saturationValue: Double = Double(rowData[index]) / Double(targetValue)
                RoundedRectangle(cornerRadius: 5.0)
                    .frame(width: heatMapRectangleWidth, height: heatMapRectangleWidth, alignment: .center)
                    .foregroundColor(Color(hue: 0.329, saturation: saturationValue, brightness: 0.729))
            }
        }
        .onAppear() {
            print(rowData)
        }
    }
}
