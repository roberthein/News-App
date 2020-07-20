//
//  Resource.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation

struct Resource<T: Codable> {
    let url: URL
    let parse: (Data) -> T?
}

extension Resource {
    
    init(url: URL) {
        self.url = url
        
        parse = { data in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
