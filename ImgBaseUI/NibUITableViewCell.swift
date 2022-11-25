//
//  NibUITableViewCell.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 25/11/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import UIKit

open class NibUITableViewCell: UITableViewCell, NibUIBase {
    weak var containerView: UIView!

    open func commonInit() {
        containerViewInit()
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
