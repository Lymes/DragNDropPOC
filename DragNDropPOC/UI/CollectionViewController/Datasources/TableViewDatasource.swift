//
//  TableViewDatasource.swift
//  DragNDropPOC
//
//  Created by leonid.mesentsev on 04/03/23.
//

import UIKit

final class TableViewDatasource: UITableViewDiffableDataSource<Section, DataModel> {

    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "card",
                for: indexPath) as? CardTableViewCell
            cell?.titleLabel.text = itemIdentifier.title
            cell?.subTitleLabel.text = itemIdentifier.subtitle
            return cell
        }
    }

    func insert(_ data: DataModel, to indexPath: IndexPath) {
        var dataItems = snapshot().itemIdentifiers
        if let idx = dataItems.firstIndex(of: data) {
            dataItems.remove(at: idx)
        }
        if dataItems.indices.contains(indexPath.row) {
            dataItems.insert(data, at: indexPath.row)
        } else {
            dataItems.append(data)
        }
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(dataItems)
        apply(snapshot, animatingDifferences: false)
    }

    //
    // Opzionale, serve solo se vuoi che anche la tabella sia draggabile
    //
    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        guard let data = itemIdentifier(for: indexPath) else { return [] }
        let itemProvider = NSItemProvider(object: data.title as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = data
        return [dragItem]
    }
}
