//
//  GalleryDataSource.swift
//  Shortcuts Gallery
//
//  Created by Marco Capano on 09/07/2018.
//  Copyright © 2018 Marco Capano. All rights reserved.
//

import Foundation
import UIKit

class GalleryDataManager: NSObject {
    var shortcuts: [Shortcut]
    var details = [String: ShortcutDetail]()
    private var colors = [UIColor(red: 150/255, green: 212/255, blue: 68/255, alpha: 1.0),
                          UIColor(red: 247/255, green: 170/255, blue: 135/255, alpha: 1.0),
                          UIColor(red: 228/255, green: 103/255, blue: 158/255, alpha: 1.0),
                          UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1.0)]

    init(shortcuts: [Shortcut]) {
        self.shortcuts = shortcuts
    }
    
    override init() {
        self.shortcuts = []
    }
    
    private func getDetail(for shortcut: Shortcut, completion: @escaping (DetailResponseBlock)) {
        if let detail = details[shortcut.id!] {
            completion(detail)
        } else {
            shortcut.detail { (detail) in
                if let detail = detail {
                    completion(detail)
                }
            }
        }
    }
    
}

extension GalleryDataManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shortcuts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "galleryCell", for: indexPath) as? GalleryTableViewCell else {
            fatalError("unable to load cell in gallery")
        }
        
        let shortcut = shortcuts[indexPath.row]
        cell.titleLabel.text = shortcut.title
        cell.descriptionLabel.text = shortcut.summary
        cell.box.backgroundColor = colors.randomElement()
        
        getDetail(for: shortcut) { (detail) in
            guard let detail = detail else { return }
            
            DispatchQueue.main.async {
                cell.nameLabel.text = "CREATED BY \(detail.user.name)"
            }
        }
        
        return cell
    }
}

extension GalleryDataManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shortcut = shortcuts[indexPath.row]
        
        getDetail(for: shortcut) { (detail) in
            guard let detail = detail, let deepLink = URL(string: detail.deepLink) else  { return }
            
            DispatchQueue.main.async {
                UIApplication.shared.open(deepLink, options: [:], completionHandler: nil)
            }
        }
    }
}

