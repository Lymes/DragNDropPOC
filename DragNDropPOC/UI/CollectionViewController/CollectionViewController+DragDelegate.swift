//
//  CollectionViewController+DragDelegate.swift
//  DragNDropPOC
//
//  Created by leonid.mesentsev on 04/03/23.
//

import UIKit

// MARK: UICollectionView drag

extension CollectionViewController: UICollectionViewDragDelegate {

    //
    // Qui prendiamo gli item da trascinare dal datasource della collectionView
    //
    func collectionView(_ collectionView: UICollectionView,
                        itemsForBeginning session: UIDragSession,
                        at indexPath: IndexPath) -> [UIDragItem] {
        return collectionDatasource?.dragItems(for: indexPath) ?? []
    }

    //
    // Ritagliamo la preview della card per nascondere il bordo brutto
    // NB: non ci serve l'ombra perche' la preview ne ha gia' una sua.
    //
    func collectionView(_ collectionView: UICollectionView,
                        dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let previewParams = UIDragPreviewParameters()
        if let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
            let path = UIBezierPath(
                roundedRect: cell.cardView.frame,
                cornerRadius: cell.cardView.layer.cornerRadius
            )
            previewParams.visiblePath = path
        }
        return previewParams
    }

    //
    // Questi 2 metodi sono opzionali e servono solo per evidenziare la cella
    // che viene trascinata senza ricaricare la collection.
    // Io semplicemente coloro lo sfondo a rosso.
    //

    func collectionView(_ collectionView: UICollectionView, dragSessionWillBegin session: UIDragSession) {
        if let item = session.items.first?.localObject as? DataModel,
           let indexPath = collectionDatasource?.indexPath(for: item),
           let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
            cell.cardView.backgroundColor = .red
        }
    }

    func collectionView(_ collectionView: UICollectionView, dragSessionDidEnd session: UIDragSession) {
        if let item = session.items.first?.localObject as? DataModel,
           let indexPath = collectionDatasource?.indexPath(for: item),
           let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
            cell.cardView.backgroundColor = .white
        }
    }
}

// MARK: UITableView drag  (Questo delegato e' opzionale, solo se vuoi che anche la tabella sia draggabile)

extension CollectionViewController: UITableViewDragDelegate {

    //
    // Qui prendiamo gli item da trascinare dal datasource della tableView
    //
    func tableView(_ tableView: UITableView,
                   itemsForBeginning session: UIDragSession,
                   at indexPath: IndexPath) -> [UIDragItem] {
        return tableDatasource?.dragItems(for: indexPath) ?? []
    }

    //
    // Ritagliamo la preview della card per nascondere il bordo
    //
    func tableView(_ tableView: UITableView,
                   dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let previewParams = UIDragPreviewParameters()
        if let cell = tableView.cellForRow(at: indexPath) as? CardTableViewCell {
            let path = UIBezierPath(
                roundedRect: cell.cardView.frame,
                cornerRadius: cell.cardView.layer.cornerRadius
            )
            previewParams.visiblePath = path
        }
        return previewParams
    }
}
