//
//  UsersVC.swift
//  DevChat
//
//  Created by Bálint Németh on 2017. 08. 04..
//  Copyright © 2017. Németh Bálint. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class UsersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    
    private var _snapData: Data?
    private var _videoURL: URL?
    
    var snapData: Data? {
        set{
            _snapData = newValue
        } get {
            return _snapData
        }
    }
    
    var videoURL: URL? {
        set{
            _videoURL = newValue
        } get {
            return _videoURL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //unable-re allitjuk a kuldes gombot a navigationItem-be hogy ne lehessen kuldeni ha senki nincs kijelölve
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        //we need to allow multiple selection...
        tableView.allowsMultipleSelection = true
        
        DataService.instance.usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            //print("BALINT: Snap \(snapshot.debugDescription)")
            if let users = snapshot.value as? Dictionary<String, AnyObject> {
                
                for (key, value) in users {
                    
                    if let dict = value as? Dictionary<String, AnyObject> {
                        
                        if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
                            
                            if let firstName = profile["Firstname"] as? String {
                                
                                let uid = key
                                let user = User(uid: uid, firstName: firstName)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
            print("users: \(self.users)")
        })
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        if selectedUsers.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    @IBAction func sendPRBtnPressed(_ sender: Any) {
        
        if let url = _videoURL {
            
            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.videoStorageRef.child(videoName)
            
            _ = ref.putFile(from: url, metadata: nil, completion: { (meta: StorageMetadata?, error: Error?) in
                
                if error != nil {
                    
                    print("BALINT: Error uploading video \(error?.localizedDescription)")
                } else {
                    
                    let downloadURL = meta?.downloadURL()
                    //save this somewhere
                    self.dismiss(animated: true, completion: nil)
                }
            })
        } else if let snap = snapData {
            
            let snapName = "\(NSUUID().uuidString).jpeg)"
            let ref = DataService.instance.imagesStorageRef.child(snapName)
            
            _ = ref.putData(snap, metadata: nil, completion: { (meta: StorageMetadata?, error: Error?) in
                
                if error != nil {
                    
                    print("BALINT: Error uploadin image \(error?.localizedDescription)")
                } else {
                    
                    let downloadURL = meta?.downloadURL()
                    self.dismiss(animated: true, completion: nil)
                }
            })
            
            
        }
    }

}
