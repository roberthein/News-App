//
//  API.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation

class API {
    
    class func load<A>(resource: Resource<A>, completion: @escaping (A?) -> ()) {
        
        URLSession.shared
            .dataTask(with: resource.url as URL) { data, response, error in
                
                if let error = error {
                    fatalError(error.localizedDescription)
                } else if let data = data {
                    completion(resource.parse(data))
                }
            }
            .resume()
    }
}

extension API {
    static let articlesURL = URL(string: "https://gist.github.com/roberthein/b7c74071e98c94c90fb8f08472653376/raw/fa43d2a71aa52ebb6d6d5efcdf078db7c98541a6/articles.json")!
}
