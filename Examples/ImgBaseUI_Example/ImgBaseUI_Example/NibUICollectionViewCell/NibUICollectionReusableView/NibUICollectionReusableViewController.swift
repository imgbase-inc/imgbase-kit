//
//  NibUICollectionReusableViewController.swift
//  ImgBaseUI_Example
//
//  Created by odong on 2022/12/29.
//

import UIKit

class NibUICollectionReusableViewController: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
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
        collectionView.register(CustomNibUICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomNibUICollectionReusableView.reuseIdentifier)

        setLayout()
    }

    private func setLayout() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension NibUICollectionReusableViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CustomNibUICollectionReusableView.reuseIdentifier, for: indexPath)

            return headerView
        default:
            assert(false, "Assert")
        }
    }
}

extension NibUICollectionReusableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        let height = width + 80

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
}
