//
//  ViewController.swift
//  IMImageViewer_Example
//
//  Created by odong on 2023/01/05.
//

import UIKit
import IMImageViewer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showImageViewer(_ sender: UIButton) {
        let imageView = IMImageViewer(transitionStyle: .scroll, navigationOrientation: .horizontal)
        imageView.modalPresentationStyle = .fullScreen

        let headerView = UIView()
        headerView.bounds.size.height = 70

        let footerView = UIView()
        footerView.bounds.size.height = 70

        imageView.headerView = headerView
        imageView.footerView = footerView

        present(imageView, animated: true)
    }
}

