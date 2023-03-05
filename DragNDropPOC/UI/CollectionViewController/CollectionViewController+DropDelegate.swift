//
//  CollectionViewController+DropDelegate.swift
//  DragNDropPOC
//
//  Created by leonid.mesentsev on 04/03/23.
//

import UIKit

extension CollectionViewController: UITableViewDropDelegate {

    //
    // Qui possiamo controllare il contentuto di DragItem della sessione ed accettare
    // il drop solo se e' un DataModel. Ma siccome nel contesto non abbiamo altri tipi
    // draggabili semplicemente rispondiamo sempre true.
    //
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return true
    }

    //
    // Qui semplicemente inseriamo l'item droppato nel datasource della tabella
    //
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(row: -1, section: 0)
        for (index, item) in coordinator.items.enumerated() {
            let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
            if let dataModel = item.dragItem.localObject as? DataModel {
                self.tableDatasource?.insert(dataModel, to: indexPath)
            }
        }
    }

    //
    // Qui definiamo il comportamento del drop target
    //
    func tableView(_ tableView: UITableView,
                   dropSessionDidUpdate session: UIDropSession,
                   withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        var dropProposal = UITableViewDropProposal(operation: .cancel)
        guard session.items.count == 1 else { return dropProposal }
        if tableView.hasActiveDrag {
            // Drag arriva dalla tabella stessa, quindi operazione Move
            dropProposal = UITableViewDropProposal(
                operation: .move,
                intent: .insertAtDestinationIndexPath
            )
        } else {
            // Drag arriva dalla Collection e appare quel pallino verde con +
            dropProposal = UITableViewDropProposal(
                operation: .copy,
                intent: .insertAtDestinationIndexPath
            )
        }
        return dropProposal
    }
}
