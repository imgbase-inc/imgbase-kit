//
//  Color+Addition.swift
//  imgbase-kit
//
//  Created by Dongbin Kim on 02/01/2023.
//  Copyright © 2022 ImgBase, Inc. All rights reserved.
//

import SwiftUI

extension UIColor {
  var suColor: Color {
    if #available(iOS 15.0, *) {
      return Color(uiColor: self)
    }

    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0

    self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    return Color(red: red, green: green, blue: blue)
  }
}
