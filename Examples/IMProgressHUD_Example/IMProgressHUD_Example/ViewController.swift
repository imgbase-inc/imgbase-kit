//
//  ViewController.swift
//  IMProgressHUD_Example
//
//  Created by odong on 2022/12/30.
//

import IMProgressHUD
import UIKit

// MARK: LayoutConstants
extension ViewController {
  private struct LayoutConstants {
    static let tableViewHeaderViewHeight: CGFloat = 30
  }
}

extension ViewController {
  private enum Selection: String {
    case infiniteRing = "InfiniteRing"
    case infiniteRingWithText = "InfiniteRing Text"
    case customImage = "Custom Image"
    case customImageWithText = "Custom Image + Text"
    case dismiss = "Dismiss"
    case success = "Success"
    case fail = "Fail"
    case noneBackground = "None"
    case blackBackground = "Black"
    case blurBackground = "Blur"
    case userInteratable = "True"
    case notUserInteractable = "False"
  }
}

final class ViewController: UIViewController {
  private typealias SelectionGroup = (groupName: String, selections: [Selection])

  private let selection: [SelectionGroup] = [
    (
      "Basic",
      [
        .infiniteRing,
        .infiniteRingWithText,
        .customImage,
        .customImageWithText,
      ]
    ),
    (
      "Dismiss",
      [
        .dismiss
      ]
    ),
    (
      "Success / Fail",
      [
        .success,
        .fail,
      ]
    ),
    (
      "Background",
      [
        .noneBackground,
        .blackBackground,
        .blurBackground,
      ]
    ),
    (
      "User Interaction",
      [
        .userInteratable,
        .notUserInteractable,
      ]
    ),
  ]

  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self

    setHUDSettings()
  }

  private func setHUDSettings() {
    IMProgressHUD.setForegroundColor(UIColor.orange)
    IMProgressHUD.setMinimumSize(CGSize(width: 100, height: 100))
    IMProgressHUD.setBackgroundColor(UIColor.systemGray5)
    IMProgressHUD.setCornerRadius(10)
    IMProgressHUD.setImageViewSize(CGSize(width: 44, height: 44))
    IMProgressHUD.setRingThickness(4)
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
    cell.textLabel?.text = selection[indexPath.section].selections[indexPath.row].rawValue

    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selection = selection[indexPath.section].selections[indexPath.row]

    switch selection {
    case .infiniteRing:
      IMProgressHUD.show()
    case .infiniteRingWithText:
      IMProgressHUD.show(text: "Loading...")
    case .customImage:
      IMProgressHUD.show(with: UIImage(systemName: "figure.walk.diamond") ?? UIImage())
    case .customImageWithText:
      IMProgressHUD.show(with: UIImage(systemName: "figure.walk.diamond") ?? UIImage(), text: "Loading...")
    case .dismiss:
      IMProgressHUD.dismiss()
    case .success:
      IMProgressHUD.showSuccess()
    case .fail:
      IMProgressHUD.showFail()
    case .noneBackground:
      IMProgressHUD.show()
    case .blackBackground:
      IMProgressHUD.show(backgroundType: .black)
      hudDismissAsyncAfter { IMProgressHUD.showSuccess() }
    case .blurBackground:
      IMProgressHUD.show(backgroundType: .blur)
      hudDismissAsyncAfter { IMProgressHUD.showSuccess() }
    case .userInteratable:
      IMProgressHUD.show(isUserInteractionEnabled: true)
    case .notUserInteractable:
      IMProgressHUD.show(isUserInteractionEnabled: false)
      hudDismissAsyncAfter { IMProgressHUD.showSuccess() }
    }
  }

  private func hudDismissAsyncAfter(deadline: DispatchTime = .now() + 1.5, completion: @escaping () -> Void) {
    DispatchQueue.global().asyncAfter(deadline: deadline) {
      DispatchQueue.main.async {
        completion()
      }
    }
  }
}
