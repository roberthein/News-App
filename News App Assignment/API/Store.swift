//
//  Store.swift
//  News App Assignment
//
//  Created by Robert-Hein Hooijmans on 07/01/17.
//  Copyright © 2017 Robert-Hein Hooijmans. All rights reserved.
//

import Foundation

protocol Storable {
    var fileName: String { get }
    func encode() -> Data
}

class Store {
    let path: URL
    let queue = OperationQueue()
    let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let fileManager = FileManager.default
    let directory = "store"
    
    init() {
        path = URL(fileURLWithPath: documents).appendingPathComponent("\(directory)", isDirectory: true)
        
        do {
            try fileManager.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func persist(_ object: Storable) {
        let url = path.appendingPathComponent(object.fileName, isDirectory: false)
        let operation = BlockOperation {
            do {
                try object.encode().write(to: url, options: [.atomicWrite])
            } catch {
                print(error.localizedDescription)
            }
        }
        
        queue.addOperation(operation)
    }
    
    func persisted() -> [Data]? {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: documents.appending("/" + directory + "/"))
            
            if files.count == 0 {
                return nil
            }
            
            return files.compactMap {
                self.fileManager.contents(atPath: documents.appending("/" + directory + "/").appending($0))
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
