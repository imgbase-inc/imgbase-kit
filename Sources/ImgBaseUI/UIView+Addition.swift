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
        let nibView: UIView = UINib.init(nibName: nibName, bundle: bundle).instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
}
