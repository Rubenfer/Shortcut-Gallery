//
//  ViewController.swift
//  Shortcuts Gallery
//
//  Created by Marco Capano on 09/07/2018.
//  Copyright © 2018 Marco Capano. All rights reserved.
//

import UIKit

class GalleryTableViewController: UITableViewController {
    
    let dataManager = GalleryDataManager()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gallery"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(showAbout), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
        
        tableView.register(UINib(nibName: "GalleryTableViewCell", bundle: nil), forCellReuseIdentifier: "galleryCell")
        tableView.dataSource = dataManager
        tableView.delegate = dataManager
        tableView.separatorStyle = .none
        tableView.contentInset.top = 30
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        
        load()
    }
    
    @objc private func showAbout() {
        let about = AboutTableViewController()
        navigationController?.pushViewController(about, animated: true)
    }
    
    @objc private func search() {
        let alert = UIAlertController(title: "Search Shortcuts", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = ""
        })
        let search = UIAlertAction(title: "Search", style: .default) { Void in
            let textToSearch = alert.textFields?.first?.text
            Shortcut.search(textToSearch!) { (response) in
                DispatchQueue.main.async {
                    self.dataManager.shortcuts = response.results
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
            }
        }
        alert.addAction(search)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc private func load() {
        Shortcut.loadLatest { (response) in
            DispatchQueue.main.async {
                self.dataManager.shortcuts = response.results
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
}

