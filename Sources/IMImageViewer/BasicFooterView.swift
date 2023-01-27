//
//  File.swift
//  
//
//  Created by odong on 2023/01/26.
//

import UIKit

open class BasicFooterView: UIView {
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: LayoutConstants.footerViewHeight))
    }
}
