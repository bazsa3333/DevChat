//
//  LoginVC.swift
//  DevChat
//
//  Created by Németh Bálint on 2017. 07. 31..
//  Copyright © 2017. Németh Bálint. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: RoundTextField!
    @IBOutlet weak var passwordField: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text , (email.characters.count > 0 && password.characters.count > 0) {
            
            //Call the log in service
            AuthService.instance.login(email: email, password: password, onComplete: { (error, data) in
                
                guard error == nil else{
                    
                    let alert = UIAlertController(title: "Error authenticating", message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            
            let alert = UIAlertController(title: "Username and password required", message: "You must enter both!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

}
