//
//  File.swift
//  
//
//  Created by odong on 2023/01/02.
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
