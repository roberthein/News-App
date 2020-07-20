//
//  Foundation.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

extension Collection {
    
    subscript (safe index: Index) -> Iterator.Element? {
        (index >= startIndex && index < endIndex) ? self[index] : nil
    }
}

extension UIColor {
    
    static var tint: UIColor {
        UIColor(red: 0, green: 183/255, blue: 255/255, alpha: 1)
    }
    
    static var background: UIColor {
        UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    }
    
    static var darkGray: UIColor {
        UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1)
    }
    
    static var darkerGray: UIColor {
        UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
    }
}
