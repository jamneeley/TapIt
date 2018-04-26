//
//  User + Convenience.swift
//  TapIt
//
//  Created by Michael Flowers on 4/26/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation
import CoreData

extension User {
    convenience init (username: String, score: Int16, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.username = username
        self.score = score
    }
}
