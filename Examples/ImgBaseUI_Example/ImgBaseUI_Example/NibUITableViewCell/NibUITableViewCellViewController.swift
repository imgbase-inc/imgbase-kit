//
//  NibUITableViewCellViewController.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/12/01.
//

import UIKit

class NibUITableViewCellViewController: UIViewController {
    private let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.register(CustomNibUITableViewCell.self, forCellReuseIdentifier: CustomNibUITableViewCell.reuseIdentifier)
        
        setLayout()
    }
    
    private func setLayout() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.rowHeight = 100
    }
}

extension NibUITableViewCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomNibUITableViewCell.reuseIdentifier, for: indexPath) as! CustomNibUITableViewCell
        
        cell.titleLabel.text = "Title입니다."
        cell.subTitleLabel.text = "SubTitle입니다."
        cell.myImageView.image = UIImage(systemName: "pencil")
        return cell
    }
}

