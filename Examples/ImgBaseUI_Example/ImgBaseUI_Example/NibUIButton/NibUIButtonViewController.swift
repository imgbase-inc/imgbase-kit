//
//  NibUIButtonViewController.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/12/01.
//

import UIKit

class NibUIButtonViewController: UIViewController {
    @IBOutlet weak var customButton: CustomNibUIButton!
    
    private var isWhite: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        customButton.setColor(isWhite: isWhite)
    }

    @IBAction func customButtonAction(_ sender: CustomNibUIButton) {
        self.isWhite.toggle()
        setBackgroundColor()
        customButton.setColor(isWhite: isWhite)
    }
    
    private func setBackgroundColor() {
        self.view.backgroundColor = self.isWhite ? .white : .darkGray
    }
}
