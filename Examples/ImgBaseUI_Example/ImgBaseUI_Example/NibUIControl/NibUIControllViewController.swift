//
//  NibUIControllViewController.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2023/01/11.
//

import UIKit

class NibUIControlViewController: UIViewController {
    @IBOutlet weak var customControl: CustomNibUIControl!
    @IBOutlet weak var tapCountLabel: UILabel!

    private var tapCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setTapCountLabel()
    }

    @IBAction func tapCustomUIControl(_ sender: CustomNibUIControl) {
        tapCount += 1
        setTapCountLabel()
        print("Tapped")
    }

    private func setTapCountLabel() {
        tapCountLabel.text = "\(tapCount)"
    }
}
