import Foundation
import UIKit

protocol CharacterView: UIView {
    func makeViews()
    func update(with data: CharacterViewData)
    func updateCharacter(url: String, with data: CharacterCellData)
}

class CharacterViewImp: UIView, CharacterView {

    private var data: [CharacterCellData] = []

    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: layout())
    }()

    func makeViews() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self

        let nib = UINib(nibName: CharacterCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CharacterCell.className)
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 59).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
    }

    func update(with data: CharacterViewData) {
        self.data = data.cells
        collectionView.reloadData()
    }

    func updateCharacter(url: String, with data: CharacterCellData) {
        guard let index = self.data.firstIndex(where: { $0.url == url }) else {
            return
        }
        self.data[index] = data
        guard let cell = collectionView.cellForItem(at: .init(row: index, section: 0)) as? CharacterCell else {
            return
        }
        cell.viewModel = data
    }

    // MARK: - Private methods

    private func layout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(sectionProvider: provider())
    }

    private func provider() -> UICollectionViewCompositionalLayoutSectionProvider {
        { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(167),
                heightDimension: .estimated(167)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .estimated(167*2),
                heightDimension: .estimated(167)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 2
            )
            group.interItemSpacing = .fixed(16)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 30
            return section
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CharacterViewImp: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        data.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCell.className,
            for: indexPath
        ) as? CharacterCell else {
            return UICollectionViewCell()
        }
        guard data.count > indexPath.row else {
            return cell
        }
        cell.viewModel = data[indexPath.row]
        return cell
    }
}
