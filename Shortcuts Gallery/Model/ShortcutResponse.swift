//
//  ShortcutResponse.swift
//  Shortcuts Gallery
//
//  Created by Marco Capano on 09/07/2018.
//  Copyright © 2018 Marco Capano. All rights reserved.
//

import Foundation

struct ShortcutResponse: Codable {
    let count: Int
    let results: [Shortcut]
}
