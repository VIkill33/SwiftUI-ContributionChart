import SwiftUI
import UIKit

@available(iOS 13, macOS 10.15, watchOS 6, *)
public struct ContributionChartView: View {
    
    var data: [Double]
    var rows: Int
    var columns: Int
    var targetValue: Double
    var blockColor: Color = Color.green
    var heatMapRectangleWidth: Double = 20.0
    var heatMapRectangleSpacing: Double = 2.0
    
    public init(data: [Double], rows: Int, columns: Int, targetValue: Double, blockColor: Color = Color.green, RectangleWidth: Double = 20.0, RectangleSpacing: Double = 2.0){
        self.data = data
        self.rows = rows
        self.columns = columns
        self.targetValue = targetValue
        self.blockColor = blockColor
        self.heatMapRectangleWidth = RectangleWidth
        self.heatMapRectangleSpacing = RectangleSpacing
    }
    
    public var body: some View {
        HStack(spacing: heatMapRectangleSpacing) {
            ForEach(0..<columns) { i in
                let start = i * rows
                let end = (i + 1) * rows
                let splitedData = Array(data[start..<end])
                ContributionChartRowView(rowData: splitedData,
                               rows: rows,
                               targetValue: targetValue,
                               blockColor: blockColor,
                               heatMapRectangleWidth: heatMapRectangleWidth,
                               heatMapRectangleSpacing: heatMapRectangleSpacing
                )
            }
        }
        .padding()
    }
}

struct ContributionChartRowView: View {
    
    var rowData: [Double]
    var rows: Int
    var targetValue: Double
    var blockColor: Color
    var heatMapRectangleWidth: Double
    var heatMapRectangleSpacing: Double
    var body: some View {
        VStack(spacing: heatMapRectangleSpacing) {
            ForEach(0..<rows) { index in
                let opacityRatio: Double = Double(rowData[index]) / Double(targetValue)
                ZStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .frame(width: heatMapRectangleWidth, height: heatMapRectangleWidth, alignment: .center
                        )
                        .foregroundColor(Color("BlockBackgroundColor"))
                    RoundedRectangle(cornerRadius: 5.0)
                        .frame(width: heatMapRectangleWidth, height: heatMapRectangleWidth, alignment: .center)
                        .foregroundColor(blockColor).opacity(opacityRatio)
                }
            }
        }
        .onAppear() {
            print(rowData)
        }
    }
}
