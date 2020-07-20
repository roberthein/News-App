//
//  ArticleCollectionViewCell.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit

protocol ArticleCollectionViewCellDelegate: AnyObject {
    func showReadMore(for article: Article)
}

class ArticleCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ArticleCollectionViewCell"
    
    weak var delegate: ArticleCollectionViewCellDelegate?
    
    var article: Article? {
        didSet {
            guard let article = article else { return }
            
            title = article.title
            text = article.text
            date = article.date
            
            setNeedsLayout()
            layoutIfNeeded()
            updateBottomBlock()
        }
    }
    
    lazy var topBlockView = BlockView(position: .top)
    lazy var bottomBlockView = BlockView(position: .bottom)
    
    lazy var scrollContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alwaysBounceVertical = false
        view.contentInset.bottom = 100
        view.delegate = self
        view.contentInsetAdjustmentBehavior = .never
        
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = UIFont(name: "Palatino-BoldItalic", size: 20)
        view.textColor = .tint
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        
        return view
    }()
    
    lazy var linkButton: LinkButton = {
        let view = LinkButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        
        return view
    }()
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            
            let titleParagraphStyle = NSMutableParagraphStyle()
            titleParagraphStyle.lineSpacing = 2
            
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "Palatino-BoldItalic", size: 45)!,
                .foregroundColor: UIColor.darkGray,
                .paragraphStyle: titleParagraphStyle
            ]
            
            let attributedTitle = NSMutableAttributedString(string: title, attributes: titleAttributes)
            titleLabel.attributedText = attributedTitle
        }
    }
    
    var text: String? {
        didSet {
            guard let text = text else { return }
            
            let textParagraphStyle = NSMutableParagraphStyle()
            textParagraphStyle.lineSpacing = 8
            
            let textAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 20),
                .foregroundColor: UIColor.darkerGray,
                .paragraphStyle: textParagraphStyle
            ]
            
            let attributedText = NSMutableAttributedString(string: text, attributes: textAttributes)
            textLabel.attributedText = attributedText
        }
    }
    
    var date: Date? {
        didSet {
            guard let date = date else { return }
            
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            dateLabel.text = formatter.string(from: date)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(dateLabel)
        scrollContentView.addSubview(titleLabel)
        scrollContentView.addSubview(textLabel)
        scrollContentView.addSubview(linkButton)
        
        contentView.addSubview(topBlockView)
        contentView.addSubview(bottomBlockView)
        
        scrollView.frame(to: contentView)
        scrollContentView.width(to: scrollView)
        scrollContentView.frame(to: scrollView)
        
        dateLabel.top(to: scrollContentView, offset: 230)
        dateLabel.left(to: scrollContentView, offset: 32)
        
        titleLabel.top(to: dateLabel, dateLabel.bottomAnchor, offset: 5)
        titleLabel.left(to: scrollContentView, offset: 32)
        titleLabel.right(to: scrollContentView, offset: -32)
        
        textLabel.top(to: titleLabel, titleLabel.bottomAnchor, offset: 15)
        textLabel.left(to: scrollContentView, offset: 32)
        textLabel.right(to: scrollContentView, offset: -32)
        
        linkButton.top(to: textLabel, textLabel.bottomAnchor, offset: 20)
        linkButton.left(to: scrollContentView, offset: 32)
        linkButton.height(27)
        linkButton.bottom(to: scrollContentView)
        
        topBlockView.top(to: contentView)
        topBlockView.left(to: contentView)
        topBlockView.right(to: contentView)
        topBlockView.height(210)
        
        bottomBlockView.bottom(to: contentView)
        bottomBlockView.left(to: contentView)
        bottomBlockView.right(to: contentView)
        bottomBlockView.height(100)
    }
    
    @objc func tapped(_ sender: Any) {
        
        if let article = article {
            delegate?.showReadMore(for: article)
        }
    }
    
    override func prepareForReuse() {
        scrollView.contentOffset = .zero
        
        topBlockView.visibility = 0
        bottomBlockView.visibility = 0
    }
    
    func updateBottomBlock() {
        let greaterThanBounds = (scrollView.contentSize.height + scrollView.contentInset.bottom) > scrollView.bounds.height
        bottomBlockView.visibility = greaterThanBounds ? 1 : 0
    }
}

extension ArticleCollectionViewCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let topOffset = scrollView.contentOffset.y
        let topVisibility = topOffset.clamped(to: 20 ... 30).map(from: 20 ... 30, to: 0 ... 1)
        topBlockView.visibility = topVisibility
        
        let bottomOffset = scrollView.contentSize.height - topOffset - scrollView.bounds.height
        let bottomVisibility = bottomOffset.clamped(to: -100 ... -90).map(from: -100 ... -90, to: 0 ... 1)
        bottomBlockView.visibility = bottomVisibility
    }
}


