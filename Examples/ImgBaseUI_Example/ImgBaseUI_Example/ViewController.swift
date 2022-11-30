//
//  ViewController.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/11/30.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let selection = [
        "NibUIView",
        "NibUIButton",
        "NibUITableViewCell",
        "NibUICollectionViewCell",
        "NibUICollectionReusableView"
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
        
        configuration.text = selection[indexPath.row]
        cell.contentConfiguration = configuration
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

