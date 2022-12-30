//
//  NibUICollectionViewCellViewController.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/12/01.
//

import UIKit

// MARK: LayoutConstants
extension NibUICollectionViewCellViewController {
    private struct LayoutConstants {
        static let collectionViewMinimumLineSpacing: CGFloat = 10
        static let collectionViewNumberOfItemsInSection: Int = 10
        static let collectionViewWidthMargin: CGFloat = 30
        static let collectionViewNumberOfCellInLine: CGFloat = 2
        static let collectionViewCellRatio: CGFloat = 1.6
    }
}

class NibUICollectionViewCellViewController: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = LayoutConstants.collectionViewMinimumLineSpacing
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomNibUICollectionViewCell.self, forCellWithReuseIdentifier: CustomNibUICollectionViewCell.reuseIdentifier)

        setLayout()
    }

    private func setLayout() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension NibUICollectionViewCellViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        LayoutConstants.collectionViewNumberOfItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomNibUICollectionViewCell.reuseIdentifier, for: indexPath) as? CustomNibUICollectionViewCell else {
            fatalError("CustomNibUICollectionViewCell dequeue reusable cell 을 찾을 수 없습니다.")
        }

        cell.imageView.image = UIImage(systemName: "pencil")
        cell.imageView.tintColor = .darkGray
        cell.label.text = "This is not a pencil."

        return cell
    }
}

extension NibUICollectionViewCellViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - LayoutConstants.collectionViewWidthMargin) / LayoutConstants.collectionViewNumberOfCellInLine
        let height = width * LayoutConstants.collectionViewCellRatio

        return CGSize(width: width, height: height)
    }
}
