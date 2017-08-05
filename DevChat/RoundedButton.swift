//
//  RoundedButton.swift
//  DevChat
//
//  Created by Németh Bálint on 2017. 07. 30..
//  Copyright © 2017. Németh Bálint. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        //whenever is set didSet is gonna detect it
        didSet {
            
            layer.cornerRadius = cornerRadius
            //cut off what is behind the edges
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        
        didSet{
            
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        
        didSet {
            
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor? {
        
        didSet {
            
            backgroundColor = bgColor
        }
    }
}
