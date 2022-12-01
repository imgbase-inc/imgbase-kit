//
//  NibUIButtonViewController.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/12/01.
//

import UIKit

class NibUIButtonViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var customButton: CustomNibUIButton!
    
    private var isWhite: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setBackgroundColor()
        setLabelColor()
    }

    @IBAction func customButtonAction(_ sender: CustomNibUIButton) {
        self.isWhite.toggle()
        setBackgroundColor()
        setLabelColor()
    }
    
    private func setBackgroundColor() {
        self.view.backgroundColor = self.isWhite ? .white : .darkGray
    }
    
    private func setLabelColor() {
        self.label.textColor = self.isWhite ? .darkGray : .white
    }
    
    private func setLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80).isActive = true
        
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        customButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        customButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        customButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
