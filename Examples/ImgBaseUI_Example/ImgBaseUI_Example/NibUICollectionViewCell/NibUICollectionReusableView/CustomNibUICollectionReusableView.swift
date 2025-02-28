//
//  CustomNibUICollectionReusableView.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/12/29.
//

import ImgBaseUI
import UIKit

class CustomNibUICollectionReusableView: NibUICollectionReusableView {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLabel: UILabel!

  override var nibName: String? {
    return "CustomNibUICollectionReusableView"
  }

  static let reuseIdentifier = "CustomNibUICollectionReusableViewReuseIdentifier"
}
