//
//  SpendsApp.swift
//  Spends
//
//  Created by Wilfredo Batucan on 3/29/24.
//

import SwiftUI

@main
struct SpendsApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
