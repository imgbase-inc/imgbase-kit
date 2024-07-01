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
}
