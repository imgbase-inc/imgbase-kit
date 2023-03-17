//
//  NibUIControl.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 11/01/2023.
//  Copyright © 2023 ImgBase, Inc. All rights reserved.
//


import UIKit

open class NibUIControl: UIControl, NibUIBase {
    @IBOutlet public weak var containerView: UIView!

    open var nibName: String? {
        return nil
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
        if let nibName {
            containerView = viewFromNibForClass(nibName: nibName, withBundle: bundle)

            addSubview(containerView)
            addSubviewToFillConstraints(containerView)
            containerView.isUserInteractionEnabled = false
        }
    }
}
