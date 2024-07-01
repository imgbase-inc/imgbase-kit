//
//  NibUITableViewCell.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 25/11/2022.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import UIKit

open class NibUITableViewCell: UITableViewCell, NibUIBase {
  @IBOutlet public weak var containerView: UIView!

  open var nibName: String? {
    return nil
  }

  open var bundle: Bundle? {
    return nil
  }

  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }

  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  open func commonInit() {
    if let nibName {
      containerView = viewFromNibForClass(nibName: nibName, withBundle: bundle)

      contentView.addSubview(containerView)
      contentView.addSubviewToFillConstraints(containerView)
    }
  }
}
