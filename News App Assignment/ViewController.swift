//
//  ViewController.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    let viewModel = ArticlesViewModel()
    
    lazy var articlesView: ArticlesView = {
        let layout = ArticlesLayout(size: view.bounds.size)
        
        let view = ArticlesView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.articleDelegate = self
        
        return view
    }()
    
    lazy var header: DateHeader = {
        let view = DateHeader()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var newsTitle: NewsTitle = {
        let view = NewsTitle()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var slider: Slider = {
        let view = Slider()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    
    // MARK: View lifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        view.addSubview(articlesView)
        view.addSubview(header)
        view.addSubview(newsTitle)
        view.addSubview(slider)
        
        articlesView.frame(to: view)
        
        newsTitle.top(to: view, offset: 65)
        newsTitle.left(to: view)
        newsTitle.height(30)
        
        header.top(to: newsTitle, newsTitle.bottomAnchor, offset: 25)
        header.left(to: view)
        header.right(to: view)
        
        slider.width(300)
        slider.height(75)
        slider.centerX(to: view)
        slider.bottom(to: view, offset: -20)
        
        viewModel.loadArticles { [weak self] articles in
            guard let _self = self, articles.count > 0 else { return }
            
            let sortedArticles = articles.sorted { (lhs: Article, rhs: Article) in
                lhs.date.timeIntervalSince1970 < rhs.date.timeIntervalSince1970
            }
            
            _self.articlesView.articles = sortedArticles
            _self.header.timeString = _self.viewModel.timeString(from: sortedArticles[0].date)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

extension ViewController: ArticlesViewArticleDelegate {
    
    func didScroll(to date: Date, at scrollPosition: Float) {
        header.timeString = viewModel.timeString(from: date)
        slider.set(scrollPosition)
    }
    
    func showReadMore(for article: Article) {
        let safariViewController = SFSafariViewController(url: article.link)
        safariViewController.modalPresentationStyle = .popover
        
        present(safariViewController, animated: true, completion: nil)
    }
}

extension ViewController: SliderDelegate {
    
    func didSlide(to index: Int) {
        let offset = CGFloat(index) * articlesView.frame.width
        articlesView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
    }
}
