//
//  CollectionViewDatasource.swift
//  DragNDropPOC
//
//  Created by leonid.mesentsev on 04/03/23.
//

import UIKit

enum Section {
  case main
}

typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DataModel>

final class CollectionViewDatasource: UICollectionViewDiffableDataSource<Section, DataModel> {

    init(_ collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "card",
                for: indexPath) as? CardCollectionViewCell
            cell?.titleLabel.text = itemIdentifier.title
            cell?.subTitleLabel.text = itemIdentifier.subtitle
            return cell
        }
    }

    func setData(_ data: [DataModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        apply(snapshot, animatingDifferences: true)
    }

    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        guard let data = itemIdentifier(for: indexPath) else { return [] }
        let itemProvider = NSItemProvider(object: data.title as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = data
        return [dragItem]
    }
}
