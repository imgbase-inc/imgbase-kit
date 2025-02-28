//
//  CustomNibUITableViewCell.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/12/01.
//

import ImgBaseUI
import UIKit

class CustomNibUITableViewCell: NibUITableViewCell {
  @IBOutlet weak var myImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLabel: UILabel!

  override var nibName: String? {
    return "CustomNibUITableViewCell"
  }

  static let reuseIdentifier = "CustomNibUITableViewCellReuseIdentifier"
}
