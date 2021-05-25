//
//  FirebaseConstants.swift
//  MECA
//
//  Created by Macbook  on 25/05/21.
//

import Foundation
import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("admin-user/1")
    }
}
