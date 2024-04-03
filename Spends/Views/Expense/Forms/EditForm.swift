//
//  Edit.swift
//  Spends
//
//  Created by Wilfredo Batucan on 3/29/24.
//

import SwiftUI

struct EditForm: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss

    var item: FetchedResults<Item>.Element
    
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
            .onAppear(perform: {
                name = item.name!
                desc = item.desc!
                amount = item.amount
                date = item.date!
            })
            
            .navigationTitle("Edit Expense")
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
                        DataController().editItem(item: item, name: name, amount: amount, desc: desc, date: date, context: managedObjContext)
                        dismiss()
                    } label: {
                        Text("Update")
                            .bold()
                    }
                    .disabled(name.isEmpty || desc.isEmpty)

                }
            }
        }
    }
}

//
//#Preview {
//    Edit()
//}
