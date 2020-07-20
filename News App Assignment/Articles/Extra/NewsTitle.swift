//
//  NewsTitle.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

class NewsTitle: UIView {
    
    var news: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .tint
        
        news = UILabel()
        news.translatesAutoresizingMaskIntoConstraints = false
        news.numberOfLines = 1
        news.font = UIFont.boldSystemFont(ofSize: 14)
        news.textColor = .background
        news.text = "TODAYS NEWS"
        addSubview(news)
        
        news.top(to: self)
        news.left(to: self, offset: 32)
        news.bottom(to: self)
        news.right(to: self, offset: -12)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath
        layer.mask = mask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
