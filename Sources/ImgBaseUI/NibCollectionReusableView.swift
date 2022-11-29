//
//  NibCollectionReusableView.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 25/11/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import UIKit

open class NibCollectionReusableView: UICollectionReusableView, NibUIBase {
    @IBOutlet public weak var containerView: UIView!
    
    open var nibName: String {
        return String(describing: Self.self)
    }
    
    open var bundle: Bundle? {
        return nil
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open func commonInit() {
        containerView = viewFromNibForClass(nibName: nibName, withBundle: bundle)

        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
