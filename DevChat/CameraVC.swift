//
//  ViewController.swift
//  DevChat
//
//  Created by Németh Bálint on 2017. 07. 28..
//  Copyright © 2017. Németh Bálint. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: AAPLCameraViewController, AAPLCameraVCDelegate {

    @IBOutlet weak var previewView: AAPLPreviewView!
    
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    
    override func viewDidLoad() {
        
        //super.viewDidLoad() elött kell csinálni mert még nem rendeltünk hozzá semmit és az AAPLcameraViewController viewDidLoad után elkezdene mindent betölteni
        //nem muszaj a self-et elé írni
        
        _previewView = previewView
        delegate = self

        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //If the user not loged in...
        //We don't have a userVC yet, so cannot Log out for testing
//        guard Auth.auth().currentUser != nil else {
//            
//            performSegue(withIdentifier: "LoginVC", sender: nil)
//            return
//        }
        performSegue(withIdentifier: "LoginVC", sender: nil)
    }


    @IBAction func recordBtnPressed(_ sender: Any) {
        
        toggleMovieRecording()
    }
    
    @IBAction func changeCameraBtnPressed(_ sender: Any) {
        
        changeCamera()
    }
    
    func shouldEnableCameraUI(_ enable: Bool) {
        
        cameraBtn.isEnabled = enable
        print("Should enable camera UI \(enable)")
    }
    
    func shouldEnableRecordUI(_ enable: Bool) {
        
        recordBtn.isEnabled = enable
        print("Should enable record UI \(enable)")
    }
    
    func canStartRecording() {
        
        print("Can start recording")
    }
    
    func recordingHasStarted() {
        
        print("Record has started")
    }
    
}

