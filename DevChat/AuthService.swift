//
//  AuthService.swift
//  DevChat
//
//  Created by Németh Bálint on 2017. 07. 31..
//  Copyright © 2017. Németh Bálint. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errMsg: String?, _ data: AnyObject?) -> Void

class AuthService {
    
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: Completion?) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    
                    if errorCode == AuthErrorCode.userNotFound {
                    
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            
                            if error != nil {
                                
                                //Show error to user
                                self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                            } else {
                                
                                if user?.uid != nil {
                                    
                                    //elmentjük a user-t a Firebase database-be
                                    DataService.instance.saveUser(uid: user!.uid)
                                    
                                    //Sign in
                                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                        
                                        if error != nil {
                                            
                                            //Show error to user
                                            self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                                        } else {
                                            
                                            //Succesfully logged in
                                            onComplete?(nil, user)
                                        }
                                    })
                                }
                            }
                        })
                    }
                } else {
                    
                    //Handle all other errors
                    self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                }
            } else {
                
                //Succesfully logged in
                onComplete?(nil, user)
            }
        }
    }
    
    func handleFirebaseError(error: NSError, onComplete: Completion?) {
        
        print(error.description)
        
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            
            switch (errorCode) {
            case AuthErrorCode.invalidEmail:
                //erroMsg a completion handler-el és nincs adat még!
                onComplete?("Invalid email address!", nil)
                break
            case AuthErrorCode.wrongPassword:
                onComplete?("Invalid password!", nil)
                break
            case AuthErrorCode.emailAlreadyInUse, AuthErrorCode.accountExistsWithDifferentCredential:
                onComplete?("Could not create account! Email already in use!", nil)
                break
            default:
                onComplete?("There was a problem authenticating. Try again!", nil)
            }
        }
    }
}
