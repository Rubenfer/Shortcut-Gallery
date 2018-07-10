//
//  AboutTableViewController.swift
//  Shortcuts Gallery
//
//  Created by Marco Capano on 09/07/2018.
//  Copyright © 2018 Marco Capano. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.frame, style: UITableViewStyle.grouped)
        title = "About"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = indexPath.section == 0 ? (indexPath.row == 0 ? "marcocapano" : "@marcocapano1") : (indexPath.row == 0 ? "@RubenApps" : "@_inside")
        let image = indexPath == IndexPath(row: 0, section: 0) ? UIImage(named: "linkedin") : UIImage(named: "twitter")
        cell.accessoryView = UIImageView(image: image!)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "CREATED BY:" : "SPECIAL THANKS TO:"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 1 ? "This work was only possible thanks to Guilhermo Rambo sharecuts.app website." : nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var string: String
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            string = "https://www.linkedin.com/in/marcocapano/"
        case IndexPath(row: 1, section: 0):
            string = "https://twitter.com/marcocapano1"
        case IndexPath(row: 0, section: 1):
            string = "https://twitter.com/RubenApps"
        case IndexPath(row: 1, section: 1):
            string = "https://twitter.com/_inside"
        default:
            string = "https://twitter.com/marcocapano1"
        }
        
        if let url = URL(string: string) {
            UIApplication.shared.open(url, options: [:]) { _ in
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        
    }
    
}
