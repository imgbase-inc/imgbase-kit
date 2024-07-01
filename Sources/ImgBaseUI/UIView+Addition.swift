//
//  UIView+Addition.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 29/11/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//
import UIKit

extension UIView {
  func viewFromNibForClass(nibName: String, withBundle bundle: Bundle?) -> UIView {
    guard let nibView: UIView = UINib.init(nibName: nibName, bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView else {
      fatalError("\(nibName) Nib을 찾을 수 없습니다.")
    }
    return nibView
  }

  func addSubviewToFillConstraints(_ subview: UIView) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
    NSLayoutConstraint.activate([
      subview.leadingAnchor.constraint(equalTo: leadingAnchor),
      subview.trailingAnchor.constraint(equalTo: trailingAnchor),
      subview.topAnchor.constraint(equalTo: topAnchor),
      subview.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
