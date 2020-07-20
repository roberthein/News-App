//
//  Date.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 18/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation

struct Time {
    let hours: Int
    let minutes: Int
}

extension Date {
    
    func time() -> Time {
        Time(hours: hours(), minutes: minutes())
    }
    
    func hours() -> Int {
        Calendar.current.component(.hour, from: self)
    }
    
    func minutes() -> Int {
        Calendar.current.component(.minute, from: self)
    }
}
