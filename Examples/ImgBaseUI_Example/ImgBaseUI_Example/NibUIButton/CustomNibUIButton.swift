//
//  CustomNibUIButton.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/12/01.
//

import UIKit
import ImgBaseUI

class CustomNibUIButton: NibUIButton {
  @IBOutlet weak var innerView: UIView!
  @IBOutlet weak var label: UILabel!

  override var nibName: String? {
    return "CustomNibUIButton"
  }

  func setColor(isWhite: Bool) {
    innerView.backgroundColor = isWhite ? .white : .darkGray
    label.textColor = isWhite ? .darkGray : .white
  }
}
