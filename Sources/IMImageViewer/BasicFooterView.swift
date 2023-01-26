//
//  File.swift
//  
//
//  Created by odong on 2023/01/26.
//

import UIKit

open class BasicFooterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .black
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
