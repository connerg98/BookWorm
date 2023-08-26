//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Conner Glasgow on 4/15/22.
//

import SwiftUI

@main
struct BookWormApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
