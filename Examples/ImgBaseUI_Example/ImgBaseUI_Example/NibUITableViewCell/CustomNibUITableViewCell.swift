//
//  CustomNibUITableViewCell.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/12/01.
//

import UIKit
import ImgBaseUI

class CustomNibUITableViewCell: NibUITableViewCell {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
}
