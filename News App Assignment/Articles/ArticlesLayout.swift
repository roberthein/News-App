//
//  ArticlesLayout.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

class ArticlesLayout: UICollectionViewFlowLayout {
    
    convenience init(size: CGSize) {
        self.init()
        
        itemSize = size
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
}
