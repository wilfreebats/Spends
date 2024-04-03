//
//  ChartMonthly.swift
//  Spends
//
//  Created by Wilfredo Batucan on 3/30/24.
//

import SwiftUI
import Charts

struct ChartMonthly: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var item: FetchedResults<Item>
    
    var body: some View {
        Chart {
            ForEach(item) { item in
                BarMark(x: .value("Month", item.date!, unit: .month),
                        y: .value("Expense", item.amount))
            }
        }
        .frame(height: 200)
    }
}

#Preview {
    ChartMonthly()
}
