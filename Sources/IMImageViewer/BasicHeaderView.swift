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

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(selectButton)
        self.addSubview(closeButton)

        self.backgroundColor = .black

        setLayout()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
