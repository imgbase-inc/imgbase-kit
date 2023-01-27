//
//  File.swift
//  
//
//  Created by odong on 2023/01/26.
//

import UIKit

open class BasicHeaderView: UIView {
    private lazy var selectButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.setImage(UIImage(named: "btnAssetPickerCheckBlack"), for: .normal)
        button.setImage(UIImage(named: "btnAssetPickerCheck"), for: .selected)
//        button.addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        return button
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "btnNaviBarBackArrow"), for: .normal)
//        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        button.frame = CGRect(x: 2, y: 0, width: 44, height: 44)
        button.contentEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        return button
    }()

    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: LayoutConstants.footerViewHeight))

        self.addSubview(selectButton)
        self.addSubview(closeButton)

        setLayout()
    }
    
    private func setLayout() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            closeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            selectButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            selectButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
