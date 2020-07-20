//
//  ArticlesViewModel.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation

struct ArticlesViewModel {
    
    func loadArticles(_ completion: @escaping ([Article]) -> Void) {
        
        DispatchQueue(label: "", qos: .userInitiated).async {
            
            if let articles = Article.persisted() {
                DispatchQueue.main.async {
                    completion(articles)
                }
            } else {
                API.load(resource: Article.resource) { articles in
                    guard let articles = articles else { return }
                    
                    for article in articles {
                        article.persist()
                    }
                    
                    DispatchQueue.main.async {
                        completion(articles)
                    }
                }
            }
        }
    }
    
    func timeString(from date: Date) -> String {
        let time = date.time()
        
        return String(format: "%02d:%02d", time.hours, time.minutes)
    }
}
