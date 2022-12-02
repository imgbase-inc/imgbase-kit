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
        myView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        myView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
