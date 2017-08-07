//
//  DataService.swift
//  DevChat
//
//  Created by Bálint Németh on 2017. 08. 04..
//  Copyright © 2017. Németh Bálint. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataService {
    
    private static let _instance = DataService()
    
    static var instance: DataService {
        
        return _instance
    }
    
    var mainRef: DatabaseReference {
        
        return Database.database().reference()
    }
    
    var usersRef: DatabaseReference {
        
        return mainRef.child("users")
    }
    
    var mainStorageRef: StorageReference {
        
        return Storage.storage().reference(forURL: "gs://devchat-19620.appspot.com")
    }
    
    var imagesStorageRef: StorageReference {
        
        return mainStorageRef.child("images")
    }
    
    var videoStorageRef: StorageReference {
        
        return mainStorageRef.child("videos")
    }
    
    func saveUser(uid: String) {
        
        let profile: Dictionary<String, AnyObject> = ["Firstname": "" as AnyObject, "Lastname": "" as AnyObject]
        mainRef.child("users").child(uid).child("profile").setValue(profile)
    }
}
