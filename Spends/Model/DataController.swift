//
//  DataController.swift
//  Spends
//
//  Created by Wilfredo Batucan on 3/29/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ItemModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("DEBUG: Unable to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("DEBUG: Data save successfully.")
        } catch {
            print("DEBUG: Unable to save data \(error.localizedDescription)")
        }
    }
    
    func addItem(name: String, amount: Double, desc: String, date: Date, context: NSManagedObjectContext) {
        let item = Item(context: context)
        item.id = UUID()
        item.name = name
        item.amount = amount
        item.date = date
        item.desc = desc
        
        save(context: context)
    }
    
    func editItem(item: Item ,name: String, amount: Double, desc: String, date: Date, context: NSManagedObjectContext) {
        
        item.name = name
        item.amount = amount
        item.date = date
        item.desc = desc
        
        save(context: context)
    }
    
    func deleteItem(item: Item ,context: NSManagedObjectContext) {
        do {
            context.delete(item)
            try context.save()
            print("DEBUG: Data delete successfully.")
        } catch {
            print("DEBUG: Unable to delete data \(error.localizedDescription)")
        }
    }
}
