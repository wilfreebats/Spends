//
//  ChartView.swift
//  Spends
//
//  Created by Wilfredo Batucan on 3/29/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var item: FetchedResults<Item>
    @FetchRequest(sortDescriptors: [SortDescriptor(\Item.date, order: .reverse)]) var itemData: FetchedResults<Item>
    @FetchRequest(sortDescriptors: [SortDescriptor(\Item.amount, order: .reverse)]) var itemDataAmount: FetchedResults<Item>
    
    @State private var selectionTabDate = TabDate.month
    @State private var rawSelectedDate: Date? = nil
    
    enum TabDate {
      case week, month
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Picker("Tab Date", selection: $selectionTabDate) {
                        Text("Week").tag(TabDate.week)
                        Text("Month").tag(TabDate.month)
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom, 30)
                    
                    HStack {
                        Text("You spend")
                        
                        Text("$\(String(format: "%.2f", getExpenseLast90Days()))")
                            .bold()
                            .foregroundStyle(.blue)
                        
                        Text("for the last 90 days.")
                    }
                    .padding(.bottom, 10)
                    
                    switch selectionTabDate {
                    case .week:
                        ChartWeekly()
                        
                    case .month:
                        ChartMonthly()
                    }
                    
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("HIGHEST SPENDING ($)")
                                .font(.caption).bold()
                        }
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    
                    ForEach(itemDataAmount) { data in
                        HStack {
                            Text(data.name ?? "No Data")
                            Spacer()
                            Text(data.amount, format: .currency(code: "USD"))
                                .font(.title3).bold()
                        }
                        Divider()
                    }
                    
                } // End of VStack
                .padding()
                
            } // End of ScrollView
            
            
            .navigationTitle("Chart")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func getExpenseLast90Days() -> Double {
        var total: Double = 0
        var counter = 1
        for data in itemData {
            if counter <= 3 {
                total += data.amount
                counter += 1
            }
        }
        return total
    }
    
}

#Preview {
    ChartView()
}
