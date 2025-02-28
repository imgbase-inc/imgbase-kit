//
//  CustomNibUIViewController.swift
//  ImgBaseUI_Example
//
//  Created by Dongbin Kim on 2022/11/30.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import UIKit

class NibUIViewController: UIViewController {
  private let myView = CustomNibUIView()

  override func viewDidLoad() {
    super.viewDidLoad()

    setLayout()
  }

  private func setLayout() {
    self.view.addSubview(myView)
    myView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      myView.topAnchor.constraint(equalTo: view.topAnchor),
      myView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      myView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      myView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}
