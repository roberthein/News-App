//
//  BlockView.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

enum BlockViewPosition {
    case top
    case bottom
}

class BlockView: UIView {
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.alpha = 0
        
        return view
    }()
    
    var visibility: CGFloat = 0 {
        didSet {
            lineView.alpha = visibility
        }
    }
    
    required init(position: BlockViewPosition) {
        super.init(frame: .zero)
        
        backgroundColor = .background
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(lineView)
        
        lineView.left(to: self)
        lineView.right(to: self)
        lineView.height(1 / UIScreen.main.scale)
        
        switch position {
            case .top:
                lineView.bottom(to: self)
            case .bottom:
                lineView.top(to: self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
