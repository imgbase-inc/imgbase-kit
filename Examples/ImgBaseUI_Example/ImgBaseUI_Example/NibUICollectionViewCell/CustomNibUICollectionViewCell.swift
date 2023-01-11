//
//  CustomNibUICollectionViewCell.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/12/01.
//

import UIKit
import ImgBaseUI

class CustomNibUICollectionViewCell: NibUICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    override var nibName: String? {
        return "CustomNibUICollectionViewCell"
    }
}
