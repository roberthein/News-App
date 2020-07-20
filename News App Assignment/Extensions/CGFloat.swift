//
//  Float.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 18/07/2020.
//  Copyright © 2020 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGFloat {
    
    mutating func clamp(to range: ClosedRange<CGFloat>) {
        self = clamped(to: range)
    }
    
    func clamped(to range: ClosedRange<CGFloat>) -> CGFloat {
        Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }
    
    func map(from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        return ((self - from.lowerBound) / (from.upperBound - from.lowerBound)) * (to.upperBound - to.lowerBound) + to.lowerBound
    }
}
