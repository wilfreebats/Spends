//
//  AddExpense.swift
//  Spends
//
//  Created by Wilfredo Batucan on 3/29/24.
//

import SwiftUI

struct AddForm: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var desc: String = ""
    @State private var amount: Double = 0
    @State private var date = Date.now
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Item name") {
                    TextField("Item", text: $name)
                }
                Section("Description") {
                    TextField("Descrpition", text: $desc)
                }
                Section("Amount Spent") {
                    HStack {
                        Text("$")
                            .fontWeight(.semibold)
                        
                        TextField("0.0", value: $amount, format: .currency(code: "US")).keyboardType(.numberPad)
                    }
                }
                Section("Date") {
                    DatePicker("", selection: $date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
            }
            
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .bold()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        DataController().addItem(name: name, amount: amount, desc: desc, date: date, context: managedObjContext)
                        dismiss()
                    } label: {
                        Text("Add")
                            .bold()
                    }
                    .disabled(name.isEmpty || desc.isEmpty)

                }
            }
        }
    }
}

#Preview {
    AddForm()
}
