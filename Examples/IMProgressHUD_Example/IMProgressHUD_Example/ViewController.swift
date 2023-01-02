//
//  ViewController.swift
//  IMProgressHUD_Example
//
//  Created by odong on 2022/12/30.
//

import UIKit

extension ViewController {
    private struct LayoutConstants {
        static let tableViewHeaderViewHeight: CGFloat = 30
    }
}

final class ViewController: UIViewController {
    typealias SelectionGroup = (groupName: String, selections: [String])

    private let selection: [SelectionGroup] = [
        ("Basic", [
            "InfiniteRing",
            "InfiniteRing + Text",
            "Custom Image",
            "Custom Image + Text"
        ]),
        ("Success/Fail", [
            "InfiniteRing + Success",
            "InfiniteRing + Fail"
        ]),
        ("Background", [
            "None",
            "Black",
            "Blur"
        ]),
        ("User Interaction", [
            "True",
            "False"
        ])
    ]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return selection.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return selection[section].groupName
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return LayoutConstants.tableViewHeaderViewHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selection[section].selections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        cell.textLabel?.text = selection[indexPath.section].selections[indexPath.row]

        return cell
    }
}

extension ViewController: UITableViewDelegate {

}
