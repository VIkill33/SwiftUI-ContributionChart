//
//  ContentView.swift
//  DemoApp
//
//  Created by Qu Tian on 2024/7/31.
//

import SwiftUI
import ContributionChart


struct ContentView: View {
    @State private var data = [0.87, 0.17, 0.6, 0.21, 0.88, 0.41, 0.37, 0.39, 0.34, 0.91, 0.45, 0.51, 0.1, 0.97, 0.32, 0.72, 0.15, 0.2, 0.87, 0.86, 0.35, 0.12, 0.77, 0.56]

    var body: some View {
        RecordBlock {
            ContributionChartView(data: data, rows: 3, columns: 8, targetValue: 1.0)
        }
        .frame(width: 210, height: 95)
        .padding()
    }
}

fileprivate struct RecordBlock<Content:View>: View {
    @ViewBuilder var content:Content
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.3), radius: 16.0, y: 16.0)
            content
        }
    }
}


#Preview {
    ContentView()
}
