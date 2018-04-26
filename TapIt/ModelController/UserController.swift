//
//  UserController.swift
//  TapIt
//
//  Created by James Neeley on 4/25/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import CoreData

class UserController {
    static let shared = UserController()
    
    //because we are adding persistence and we are populating a tableview we need a place to store mulitple users
    var users: [User] = []
    
    private init (){
        users = loadFromPersistenceStore()
    }
    
    //add user
    func addUser(username: String, score: Int16){
        _ = User(username: username, score: score)
        saveToPersistenceStore()
        users = loadFromPersistenceStore()
    }
    
    //delete user
    func delete(user: User){
        user.managedObjectContext?.delete(user)
        saveToPersistenceStore()
        users = loadFromPersistenceStore()
    }
    
    //MARK: - CoreData persistence
    
    func saveToPersistenceStore(){
        do {
            try CoreDataStack.context.save()
        } catch let e {
            print("Error decoding data from filemanager: \(e), \(e.localizedDescription)")
        }
    }
    
    func loadFromPersistenceStore() -> [User]{
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try CoreDataStack.context.fetch(request)
            return users
        } catch let e {
            print("Error decoding data from filemanager: \(e), \(e.localizedDescription)")
        }
        
        return []
    }
}
