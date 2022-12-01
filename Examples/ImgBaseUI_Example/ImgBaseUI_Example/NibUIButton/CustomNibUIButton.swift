//
//  CustomNibUIButton.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/12/01.
//

import UIKit
import ImgBaseUI

class CustomNibUIButton: NibUIButton {
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var label: UILabel!
    
    private let buttonMargin: CGFloat = 4
    
    override func commonInit() {
        super.commonInit()
        
        setLayout()
    }
    
    private func setLayout() {
        innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.topAnchor.constraint(equalTo: self.topAnchor, constant: buttonMargin).isActive = true
        innerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -buttonMargin).isActive = true
        innerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: buttonMargin).isActive = true
        innerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -buttonMargin).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
