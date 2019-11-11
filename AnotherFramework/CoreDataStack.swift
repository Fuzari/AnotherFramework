//
//  CoreDataStack.swift
//  AnotherFramework
//
//  Created by Fuzari on 11/11/2019.
//  Copyright © 2019 Fuzari. All rights reserved.
//

import Foundation
import CoreData

internal final class CoreDataStack {
    
    static let shared: CoreDataStack = {
        let coreDataStack = CoreDataStack()
        return coreDataStack
    }()
    
    init() {
        createCoordinator()
    }
    
    
    lazy var readContext: NSManagedObjectContext = {
        let readContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        readContext.persistentStoreCoordinator = coordinator
        return readContext
    }()
    
    lazy var writeContext: NSManagedObjectContext = {
        let writeContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        writeContext.persistentStoreCoordinator = coordinator
        return writeContext
    }()
    
    private let managedObjectModel: NSManagedObjectModel = {
        
        
        let url = Bundle.main.url(forResource: "CoreData", withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: url)
        
        return model!
    }()
    
    private var coordinator: NSPersistentStoreCoordinator!
    
    private func createCoordinator() {
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths.first!
        
        let modelPath = URL(fileURLWithPath: path).appendingPathComponent("CoreData.sqlite").relativePath
        let url = URL(fileURLWithPath: modelPath, isDirectory: false)
        
        try! coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
    }
    
}
