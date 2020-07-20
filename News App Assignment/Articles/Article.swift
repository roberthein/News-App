//
//  Article.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation

struct Article: Codable {
    let id: Int
    let date: Date
    let title: String
    let text: String
    let link: URL
}

extension Article {
    
    static let resource = Resource<[Article]>(url: API.articlesURL)
}

extension Article: Storable {
    
    var fileName: String {
        "\(id)"
    }
    
    func encode() -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            return try encoder.encode(self)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    
    func persist() {
        let store = Store()
        store.persist(self)
    }
    
    static func persisted() -> [Article]? {
        
        if let data = Store().persisted() {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            return data.compactMap { try? decoder.decode(Article.self, from: $0) }
        }
        
        return nil
    }
}
