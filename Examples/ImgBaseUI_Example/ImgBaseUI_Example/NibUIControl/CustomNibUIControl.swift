//
//  CustomNibUIControl.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2023/01/11.
//

import UIKit
import ImgBaseUI

class CustomNibUIControl: NibUIControl {
    @IBOutlet weak var likeLabel: UILabel!
    private var isLiked = true

    override var nibName: String? {
        return "CustomNibUIControl"
    }

    override func commonInit() {
        super.commonInit()

        setLikeLabel()
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        isLiked = !isLiked
        setLikeLabel()
        sendActions(for: .valueChanged)

        return true
    }

    private func setLikeLabel() {
        likeLabel?.text = isLiked ? "👍" : "👎"
    }
}
