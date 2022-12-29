//
//  NibUICollectionViewCell.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 25/11/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import UIKit

open class NibUICollectionViewCell: UICollectionViewCell, NibUIBase {
    @IBOutlet public weak var containerView: UIView!
    
    open var nibName: String {
        return String(describing: Self.self)
    }
    
    open var bundle: Bundle? {
        return nil
    }
    
    open class var reuseIdentifier: String {
        return String(describing: Self.self) + "ReuseIdentifier"
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

        contentView.addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
