//
//  ArticlesView.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

protocol ArticlesViewArticleDelegate: AnyObject {
    func didScroll(to date: Date, at scrollPosition: Float)
    func showReadMore(for article: Article)
}

class ArticlesView: UICollectionView {
    
    weak var articleDelegate: ArticlesViewArticleDelegate?
    
    var articles: [Article] = [] {
        didSet {
            reloadData()
            collectionViewLayout.invalidateLayout()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = nil
        isOpaque = false
        delegate = self
        dataSource = self
        alwaysBounceHorizontal = true
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        delaysContentTouches = false
        
        register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: ArticleCollectionViewCell.reuseIdentifier)
    }
}

extension ArticlesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.reuseIdentifier, for: indexPath)
        
        if let cell = cell as? ArticleCollectionViewCell, let article = articles[safe: indexPath.row] {
            cell.article = article
            cell.delegate = self
        }
        
        return cell
    }
}

extension ArticlesView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = Float(scrollView.contentOffset.x / scrollView.frame.width)
        
        let from = (articles[safe: Int(floor(scrollPosition))] ?? articles[0]).date
        let to = (articles[safe: Int(ceil(scrollPosition))] ?? articles[articles.count - 1]).date
        
        let percentage = scrollPosition.truncatingRemainder(dividingBy: 1)
        let timeDiff = to.timeIntervalSince(from) * Double(percentage)
        let date = from.addingTimeInterval(timeDiff)
        
        articleDelegate?.didScroll(to: date, at: scrollPosition)
    }
}

extension ArticlesView: ArticleCollectionViewCellDelegate {
    
    func showReadMore(for article: Article) {
        articleDelegate?.showReadMore(for: article)
    }
}
