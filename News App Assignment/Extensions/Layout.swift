//
//  Layout.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

extension UIView {
    
    func center(in view: UIView, offset: CGPoint = .zero) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.x),
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.y)
            ])
    }
    
    func frame(to view: UIView, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right)
            ])
    }
    
    func size(_ size: CGSize) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height)
            ])
    }
    
    func width(_ width: CGFloat) {
        constraints.filter { constraint -> Bool in
            constraint.firstAttribute == .width
            }.forEach { constraint in
                constraint.isActive = false
        }
        
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func width(to view: UIView, _ dimension: NSLayoutDimension? = nil, offset: CGFloat = 0) {
        widthAnchor.constraint(equalTo: dimension ?? view.widthAnchor, constant: offset).isActive = true
    }
    
    func height(_ height: CGFloat) {
        constraints.filter { constraint -> Bool in
            constraint.firstAttribute == .height
            }.forEach { constraint in
                constraint.isActive = false
        }
        
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func height(to view: UIView, _ dimension: NSLayoutDimension? = nil, offset: CGFloat = 0) {
        heightAnchor.constraint(equalTo: dimension ?? view.heightAnchor, constant: offset).isActive = true
    }
    
    func leading(to view: UIView, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0) {
        leadingAnchor.constraint(equalTo: anchor ?? view.leadingAnchor, constant: offset).isActive = true
    }
    
    func left(to view: UIView, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0) {
        leftAnchor.constraint(equalTo: anchor ?? view.leftAnchor, constant: offset).isActive = true
    }
    
    func trailing(to view: UIView, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0) {
        trailingAnchor.constraint(equalTo: anchor ?? view.trailingAnchor, constant: offset).isActive = true
    }
    
    func right(to view: UIView, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0) {
        rightAnchor.constraint(equalTo: anchor ?? view.rightAnchor, constant: offset).isActive = true
    }
    
    func top(to view: UIView, _ anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0) {
        topAnchor.constraint(equalTo: anchor ?? view.topAnchor, constant: offset).isActive = true
    }
    
    func bottom(to view: UIView, _ anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0) {
        bottomAnchor.constraint(equalTo: anchor ?? view.bottomAnchor, constant: offset).isActive = true
    }
    
    func centerX(to view: UIView, _ anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0) {
        centerXAnchor.constraint(equalTo: anchor ?? view.centerXAnchor, constant: offset).isActive = true
    }
    
    func centerY(to view: UIView, _ anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0) {
        centerYAnchor.constraint(equalTo: anchor ?? view.centerYAnchor, constant: offset).isActive = true
    }
}
