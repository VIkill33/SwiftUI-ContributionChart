import SwiftUI

@available(iOS 13, macOS 10.15, watchOS 6, *)
public struct ContributionChartView: View {
    
    var data: [Double]
    var rows: Int
    var columns: Int
    var targetValue: Double
    var blockColor: Color = Color.green
    var blockBackgroundColor: Color = Color.background
    
    var heatMapRectangleWidth: Double = 20.0
    var heatMapRectangleSpacing: Double = 2.0
    var heatMapRectangleRadius: Double = 5.0
    
    public init(data: [Double], rows: Int, columns: Int, targetValue: Double, blockColor: Color = Color.green, blockBackgroundColor: Color, RectangleWidth: Double = 20.0, RectangleSpacing: Double = 2.0, RectangleRadius: Double = 5.0){
        self.data = data
        self.rows = rows
        self.columns = columns
        self.targetValue = targetValue
        self.blockColor = blockColor
        self.blockBackgroundColor = blockBackgroundColor
        self.heatMapRectangleWidth = RectangleWidth
        self.heatMapRectangleSpacing = RectangleSpacing
        self.heatMapRectangleRadius = RectangleRadius
    }
    
    public init(data: [Double], rows: Int, columns: Int, targetValue: Double, blockColor: Color = Color.green, RectangleWidth: Double = 20.0, RectangleSpacing: Double = 2.0, RectangleRadius: Double = 5.0){
        self.data = data
        self.rows = rows
        self.columns = columns
        self.targetValue = targetValue
        self.blockColor = blockColor
        self.heatMapRectangleWidth = RectangleWidth
        self.heatMapRectangleSpacing = RectangleSpacing
        self.heatMapRectangleRadius = RectangleRadius
    }
    
    public var body: some View {
        VStack {
            // Chart
            GeometryReader { geo in
                ZStack {
                    HStack(spacing: heatMapRectangleSpacing) {
                        ForEach(0..<columns, id: \.self) { i in
                            let start = i * rows
                            let end = (i + 1) * rows
                            let splitedData = Array(data[start..<end])
                            ContributionChartRowView(rowData: splitedData,
                                                     rows: rows,
                                                     targetValue: targetValue,
                                                     blockColor: blockColor,
                                                     blockBackgroundColor: blockBackgroundColor,
                                                     heatMapRectangleWidth: heatMapRectangleWidth,
                                                     heatMapRectangleSpacing: heatMapRectangleSpacing,
                                                     heatMapRectangleRadius: heatMapRectangleRadius
                            )
                        }
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .onAppear {
                    print(geo.size.width, geo.size.height)
                }
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
    var blockBackgroundColor: Color
    var heatMapRectangleWidth: Double
    var heatMapRectangleSpacing: Double
    var heatMapRectangleRadius: Double
    
    var body: some View {
        VStack(spacing: heatMapRectangleSpacing) {
            ForEach(0..<rows, id: \.self) { index in
                ZStack {
                    RoundedRectangle(cornerRadius: heatMapRectangleRadius)
                        .frame(width: heatMapRectangleWidth, height: heatMapRectangleWidth, alignment: .center
                        )
                        .foregroundColor(blockBackgroundColor)
                    RoundedRectangle(cornerRadius: heatMapRectangleRadius)
                        .frame(width: heatMapRectangleWidth, height: heatMapRectangleWidth, alignment: .center)
                        .foregroundColor(blockColor
                            .opacity(opacityRatio(index: index)))
                }
            }
        }
        .onAppear() {
            print(rowData)
        }
    }
    
    func opacityRatio(index: Int) -> Double {
        var opacityRatio: Double = Double(rowData[index]) / Double(targetValue)
        return opacityRatio > 1.0 ? 1.0 : opacityRatio
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
#if os(macOS)
    static let background = Color(NSColor.windowBackgroundColor)
    static let secondaryBackground = Color(NSColor.underPageBackgroundColor)
    static let tertiaryBackground = Color(NSColor.controlBackgroundColor)
#endif
#if os(iOS)
    static let background = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
#endif
    #if os(watchOS)
    static let background = Color.black
    #endif
}
