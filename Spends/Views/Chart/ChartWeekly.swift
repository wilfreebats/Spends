//
//  ChartWeekly.swift
//  Spends
//
//  Created by Wilfredo Batucan on 3/30/24.
//

import SwiftUI
import Charts

struct ChartWeekly: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var item: FetchedResults<Item>
    
    var body: some View {
        Chart {
            ForEach(item) { item in
                BarMark(x: .value("Week", item.date!, unit: .weekOfMonth),
                        y: .value("Expense", item.amount))
            }
        }
        .frame(height: 180)
        .chartScrollableAxes(.horizontal)
    }
}

#Preview {
    ChartWeekly()
}
