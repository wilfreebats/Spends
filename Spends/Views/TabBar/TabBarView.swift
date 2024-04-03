//
//  TabBarView.swift
//  Spends
//
//  Created by Wilfredo Batucan on 3/29/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selection: Tab = .expense
    
    enum Tab {
        case expense
        case chart
    }
    var body: some View {
        TabView {
            ExpenseList()
                .tabItem {
                    Label("Expense", systemImage: "dollarsign.square.fill")
                }
                .tag(Tab.expense)
            
            ChartView()
                .tabItem {
                    Label("Chart", systemImage: "chart.bar.fill")
                }
                .tag(Tab.chart)
        }
    }

}

#Preview {
    TabBarView()
}
