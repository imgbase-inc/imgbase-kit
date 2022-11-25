//
//  NibUIBase.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 25/11/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import UIKit

protocol NibUIBase: AnyObject {
    var containerView: UIView! { get set }
    var nibName: String? { get }
    var bundle: Bundle? { get }
    
    func commonInit()
    func loadNibToContainerView(nibName: String)
    
    func viewFromNibForClass(nibName: String, withBundle bundle: Bundle) -> UIView
    func viewFromNibForClass(nibName: String) -> UIView
}

extension NibUIBase {
    var nibName: String? { String(describing: Self.self) }
    var bundle: Bundle? { Bundle(for: Self.self) }
    
    func loadNibToContainerView(nibName: String) {
        if let bundle = bundle {
            containerView = viewFromNibForClass(nibName: nibName, withBundle: bundle)
        } else {
            Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        }
    }
    
    func viewFromNibForClass(nibName: String, withBundle bundle: Bundle) -> UIView {
        let nibView: UIView = (UINib.init(nibName: nibName, bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView)!
        return nibView
    }
    
    func viewFromNibForClass(nibName: String) -> UIView {
        let nibView: UIView = (UINib.init(nibName: nibName, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView)!
        return nibView
    }
}

// MARK: containerViewInit

extension NibUIBase where Self: UIView {
    func containerViewInit() {
        if let nibName: String = nibName {
            loadNibToContainerView(nibName: nibName)
            
            addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
}

extension NibUIBase where Self: UICollectionViewCell {
    func containerViewInit() {
        if let nibName: String = nibName {
            loadNibToContainerView(nibName: nibName)
            
            contentView.addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
}

extension NibUIBase where Self: UITableViewCell {
    func containerViewInit() {
        if let nibName: String = nibName {
            loadNibToContainerView(nibName: nibName)
            
            contentView.addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
}
