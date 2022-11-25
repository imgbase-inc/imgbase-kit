//
//  NibCollectionReusableView.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 25/11/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import UIKit

open class NibCollectionReusableView: UICollectionReusableView, NibUIBase {
    weak var containerView: UIView!

    open func commonInit() {
        containerViewInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
