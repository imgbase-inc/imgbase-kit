//
//  NibUICollectionReusableView.swift
//  imgbase-kit
//
//  Created by Hyuncheol Jeon on 27/12/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import UIKit

open class NibUICollectionReusableView: UICollectionReusableView {
    @IBOutlet public weak var containerView: UIView!
    open var nibName: String? {
        return nil
    }

    open var bundle: Bundle? {
        return nil
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
        if let nibName: String = nibName {
            if let bundle = bundle {
                containerView = viewFromNibForClass(nibName: nibName, withBundle: bundle)
            } else {
                Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
            }
            addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }

    private func viewFromNibForClass(nibName: String, withBundle bundle: Bundle) -> UIView {
        let nibView: UIView = (UINib.init(nibName: nibName, bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView)!
        return nibView
    }

    public func viewFromNibForClass(nibName: String) -> UIView {
        let nibView: UIView = (UINib.init(nibName: nibName, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView)!
        return nibView
    }
}
