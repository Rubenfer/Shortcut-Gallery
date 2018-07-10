//
//  ShortcutDetail.swift
//  Shortcuts Gallery
//
//  Created by Marco Capano on 09/07/2018.
//  Copyright © 2018 Marco Capano. All rights reserved.
//

import Foundation

typealias DetailResponseBlock = (ShortcutDetail?) ->()

struct ShortcutDetail: Codable {
    var shortcut: Shortcut
    var deepLink: String
    var download: String
    var user: User
}
