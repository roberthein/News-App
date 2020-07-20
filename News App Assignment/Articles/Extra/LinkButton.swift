//
//  LinkButton.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

class LinkButton: UIControl {
    
    var title: UILabel!
    var arrow: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textColor = .tint
        title.text = "read more".uppercased()
        addSubview(title)
        
        title.top(to: self)
        title.left(to: self)
        title.bottom(to: self)
        
        arrow = UIImageView()
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.image = UIImage(named: "icon_arrow")?.withRenderingMode(.alwaysTemplate)
        arrow.tintColor = .tint
        addSubview(arrow)
        
        arrow.left(to: title, title.rightAnchor, offset: 6)
        arrow.centerY(to: self)
        arrow.right(to: self)
    }
    
    override var isHighlighted: Bool {
        didSet {
            [title, arrow].forEach {
                $0.alpha = isHighlighted ? 0.5 : 1
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            [title, arrow].forEach {
                $0.alpha = isHighlighted ? 0.5 : 1
            }
        }
    }
}
