//
//  DataController.swift
//  BookWorm
//
//  Created by Conner Glasgow on 4/15/22.
//

import CoreData
import Foundation


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "BookWorm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data: \(error.localizedDescription)")
            }
        }
    }
}
