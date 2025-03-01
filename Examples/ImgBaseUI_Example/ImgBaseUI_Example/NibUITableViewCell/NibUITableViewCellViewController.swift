//
//  NibUITableViewCellViewController.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/12/01.
//

import UIKit

// MARK: LayoutConstants
extension NibUITableViewCellViewController {
  private struct LayoutConstants {
    static let tableViewRowHeight: CGFloat = 100
    static let tableViewNumberOfRowsInSection: Int = 10
  }
}

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

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])

    tableView.rowHeight = LayoutConstants.tableViewRowHeight
  }
}

extension NibUITableViewCellViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return LayoutConstants.tableViewNumberOfRowsInSection
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(withIdentifier: CustomNibUITableViewCell.reuseIdentifier, for: indexPath)
        as? CustomNibUITableViewCell
    else {
      fatalError("CustomNibUITableViewCell dequeue reusable cell 을 찾을 수 없습니다.")
    }

    cell.titleLabel.text = "Title" + " \(indexPath.row)"
    cell.subTitleLabel.text = "SubTitle"
    cell.myImageView.image = UIImage(systemName: "pencil")
    cell.myImageView.tintColor = .darkGray
    return cell
  }
}
