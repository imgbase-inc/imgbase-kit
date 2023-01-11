//
//  NibUICollectionReusableView.swift
//  imgbase-kit
//
//  Created by Hyuncheol Jeon on 27/12/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import UIKit

open class NibUICollectionReusableView: UICollectionReusableView, NibUIBase {
    @IBOutlet public weak var containerView: UIView!

    open var nibName: String? {
        return nil
    }

    open var bundle: Bundle? {
        return nil
    }

    open class var reuseIdentifier: String {
        return String(describing: Self.self) + "ReuseIdentifier"
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    open func commonInit() {
        if let nibName {
            containerView = viewFromNibForClass(nibName: nibName, withBundle: bundle)
            
            addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
}
