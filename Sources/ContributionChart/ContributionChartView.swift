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
    @Environment(\.colorScheme) var colorScheme
    
    var rowData: [Double]
    var rows: Int
    var targetValue: Double
    var blockColor: Color
    var heatMapRectangleWidth: Double
    var heatMapRectangleSpacing: Double
    
    let blockBackgorundColor: Color = Color(hexString: "E6E6E6")
    let darkBlockBackgorundColor: Color = Color(hexString: "161A22")
    
    var body: some View {
        VStack(spacing: heatMapRectangleSpacing) {
            ForEach(0..<rows) { index in
                let opacityRatio: Double = Double(rowData[index]) / Double(targetValue)
                ZStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .frame(width: heatMapRectangleWidth, height: heatMapRectangleWidth, alignment: .center
                        )
                        .foregroundColor(colorScheme == .dark ? darkBlockBackgorundColor : blockBackgorundColor)
                    RoundedRectangle(cornerRadius: 5.0)
                        .frame(width: heatMapRectangleWidth, height: heatMapRectangleWidth, alignment: .center)
                        .foregroundColor(blockColor
                            .opacity(opacityRatio))
                }
            }
        }
        .onAppear() {
            print(rowData)
        }
    }
}

extension Color {
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}
