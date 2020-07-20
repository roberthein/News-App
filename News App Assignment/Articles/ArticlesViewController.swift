////
////  ViewController.swift
////  robert-hein-test
////
////  Created by Robert-Hein Hooijmans on 07/01/17.
////  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
////
//
//import UIKit
//import SafariServices
//
//class ArticlesViewController: UIViewController {
//
//    lazy var articlesView: ArticlesView = {
//        let layout = ArticlesLayout(size: view.bounds.size)
//
//        let view = ArticlesView(frame: .zero, collectionViewLayout: layout)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.articleDelegate = self
//
//        return view
//    }()
//
//    lazy var header: DateHeader = {
//        let view = DateHeader()
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//    }()
//
//    lazy var newsTitle: NewsTitle = {
//        let view = NewsTitle()
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//    }()
//
//    lazy var slider: Slider = {
//        let view = Slider()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.delegate = self
//
//        return view
//    }()
//
//
//    // MARK: Initializaton
//
//
//    let viewModel: ArticlesViewModel
//
//    required init(_ viewModel: ArticlesViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    // MARK: View lifeCycle
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .background
//
//        view.addSubview(articlesView)
//        view.addSubview(header)
//        view.addSubview(newsTitle)
//        view.addSubview(slider)
//
//        articlesView.frame(to: view)
//
//        header.top(to: view, offset: 95)
//        header.left(to: view)
//        header.right(to: view)
//
//        newsTitle.top(to: view, offset: 45)
//        newsTitle.left(to: view)
//        newsTitle.height(30)
//
//        slider.width(300)
//        slider.height(75)
//        slider.centerX(to: view)
//        slider.bottom(to: view, offset: -20)
//
//        viewModel.loadArticles { [weak self] articles in
//            guard let _self = self, articles.count > 0 else { return }
//
//            let sortedArticles = articles.sorted { (lhs: Article, rhs: Article) in
//                lhs.date.timeIntervalSince1970 < rhs.date.timeIntervalSince1970
//            }
//
//            _self.articlesView.articles = sortedArticles
//            _self.header.timeString = _self.viewModel.timeString(from: sortedArticles[0].date)
//        }
//    }
//}
//
//extension ArticlesViewController: ArticlesViewArticleDelegate {
//    
//    func didScroll(to date: Date, at scrollPosition: Float) {
//        header.timeString = viewModel.timeString(from: date)
//        slider.set(scrollPosition)
//    }
//
//    func showReadMore(for article: Article) {
//        let safariViewController = SFSafariViewController(url: article.link)
//        safariViewController.modalPresentationStyle = .popover
//
//        present(safariViewController, animated: true, completion: nil)
//    }
//}
//
//extension ArticlesViewController: SliderDelegate {
//
//    func didSlide(to index: Int) {
//        let offset = CGFloat(index) * articlesView.frame.width
//        articlesView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
//    }
//}
