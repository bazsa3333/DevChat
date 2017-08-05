//
//  DataService.swift
//  DevChat
//
//  Created by Bálint Németh on 2017. 08. 04..
//  Copyright © 2017. Németh Bálint. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataService {
    
    private static let _instance = DataService()
    
    static var instance: DataService {
        
        return _instance
    }
    
    var mainRef: DatabaseReference {
        
        return Database.database().reference()
    }
    
    func saveUser(uid: String) {
        
        let profile: Dictionary<String, AnyObject> = ["Firstname": "" as AnyObject, "Lastname": "" as AnyObject]
        mainRef.child("users").child(uid).child("profile").setValue(profile)
    }
}
