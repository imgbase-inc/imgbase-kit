//
//  ViewController.swift
//  ImgBaseUI_Example
//
//  Created by Dongbin Kim on 2022/11/30.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let selection = [
        ("NibUIView", CustomNibUIViewController()),
        ("NibUIButton", CustomNibUIViewController()),
        ("NibUITableViewCell", CustomNibUIViewController()),
        ("NibUICollectionViewCell", CustomNibUIViewController()),
        ("NibUICollectionReusabelView", CustomNibUIViewController())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationBar.topItem?.title = "ImgBaseUI"
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var configuration = cell.defaultContentConfiguration()
        
        configuration.text = selection[indexPath.row].0
        cell.contentConfiguration = configuration
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(selection[indexPath.row].1, animated: true)
    }
}

