//
//  Shortcut.swift
//  Shortcuts Gallery
//
//  Created by Marco Capano on 09/07/2018.
//  Copyright © 2018 Marco Capano. All rights reserved.
//

import Foundation

typealias ShortcutsResponseBlock = (ShortcutResponse) -> ()

struct Shortcut: Codable {
    
    var id: String?
    var createdAt: String
    var updatedAt: String
    var userID: String
    
    var title: String
    var summary: String
    
    var filePath: String
    var fileID: String
    var actionCount: Int
    var actionIdentifiers: [String]
    
    init(userID: String,
         title: String,
         summary: String,
         filePath: String,
         fileID: String,
         actionCount: Int,
         actionIdentifiers: [String])
    {
        self.createdAt = ""
        self.updatedAt = ""
        self.userID = userID
        self.title = title
        self.summary = summary
        self.filePath = filePath
        self.fileID = fileID
        self.actionCount = actionCount
        self.actionIdentifiers = actionIdentifiers
    }
    
    func detail(completion: @escaping DetailResponseBlock) {
        guard let id = id, let url = URL(string: "https://sharecuts.app/api/shortcuts/\(id)") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
            } else if let data = data {
                let shortcutDetail = try? JSONDecoder().decode(ShortcutDetail.self, from: data)
                completion(shortcutDetail)
            }
        }.resume()
    }
    
    static func loadLatest(completion: @escaping ShortcutsResponseBlock) {
        guard let url = URL(string: "https://sharecuts.app/api/shortcuts/latest") else {
            completion(ShortcutResponse(count: 0, results: []))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
            } else if let data = data {
                do {
                    let shortcuts = try JSONDecoder().decode(ShortcutResponse.self, from: data)
                    completion(shortcuts)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
    
    static func search(_ keyword: String, completion: @escaping ShortcutsResponseBlock) {
        
        guard let url = URL(string: "https://sharecuts.app/api/shortcuts/latest") else {
            completion(ShortcutResponse(count: 0, results: []))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
            } else if let data = data {
                do {
                    let shortcuts = try JSONDecoder().decode(ShortcutResponse.self, from: data)
                    completion(shortcuts)
                } catch {
                    print(error.localizedDescription)
                }
            }
            }.resume()
        
    }
}

