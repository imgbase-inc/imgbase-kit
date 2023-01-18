//
//  UIView+Addition.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 16/01/2023.
//  Copyright © 2023 ImgBase, Inc. All rights reserved.
//

import UIKit

extension UIView {
    public var boundsCenter: CGPoint {
        return CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
    }
}
