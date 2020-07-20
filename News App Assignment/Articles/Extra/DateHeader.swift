//
//  DateHeader.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

class DateHeader: UIView {
    
    var timeString: String? {
        didSet {
            timeLabel.text = timeString
        }
    }
    
    private lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = UIFont(name: "Palatino-Roman", size: 80)
        view.textColor = .tint
        
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(timeLabel)
        
        timeLabel.top(to: self)
        timeLabel.left(to: self, offset: 32)
        timeLabel.bottom(to: self)
        timeLabel.right(to: self, offset: -32)
    }
}
