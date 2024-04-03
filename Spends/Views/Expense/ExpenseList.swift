//
//  ExpenseList.swift
//  Spends
//
//  Created by Wilfredo Batucan on 3/29/24.
//

import SwiftUI

struct ExpenseList: View {
    @Environment(\.managedObjectContext) var managedObjContext

    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var item: FetchedResults<Item>
    
    @State private var selectedItem: Item?
    @State private var isAddShow = false
    @State private var searchText = ""
    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            searchText = newValue
            item.nsPredicate = newValue.isEmpty ? nil : NSPredicate(format: "name CONTAINS [cd]%@", newValue)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(item) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name ?? "No data")
                            
                            Text(item.desc ?? "No data")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                            .font(.title3).bold()
                        
                    }

                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            DataController().deleteItem(item: item, context: managedObjContext)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        Button(action: {
                            selectedItem = item
                        }, label: {
                            Label("Edit", systemImage: "pencil")
                                .tint(.yellow)
                        })
                    }

                }                
                
                if !item.isEmpty {
                    HStack {
                        Text("Total: ")
                            .font(.system(size: 25)).bold()
                        
                        Spacer()
                        
                        Text(totalExpenses(), format: .currency(code: "USD"))
                            .font(.system(size: 25)).bold()
                            .foregroundStyle(.green)
                    }
                }
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: query, prompt: "Search")
            .overlay(content: {
                if searchText.isEmpty && item.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No items", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding items")
                    })
                }
                
                if !searchText.isEmpty && item.isEmpty {
                    ContentUnavailableView.search
                }
            })
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAddShow.toggle()
                    } label: {
                        Label("", systemImage: "plus.circle.fill")
                    }
                }
            }
            
            .sheet(isPresented: $isAddShow) {
                AddForm().presentationDetents([.large])
            }
            
            .sheet(item: $selectedItem) { item in
                EditForm(item: item).presentationDetents([.large])
            }
            
        }
    }
    func totalExpenses() -> Double{
        var totalExpense: Double = 0.0
        for item in item {
            totalExpense += item.amount
        }
        
        return totalExpense
    }
}

#Preview {
    ExpenseList()
}
