//
//  CustomNibUIView.swift
//  ImgBaseUI_Example
//
//  Created by Dongbin Kim on 2022/11/30.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import UIKit
import ImgBaseUI

class CustomNibUIView: NibUIView {
  @IBOutlet weak var label: UILabel!

  override var nibName: String? {
    return "CustomNibUIView"
  }

  override func commonInit() {
    super.commonInit()

    label.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
