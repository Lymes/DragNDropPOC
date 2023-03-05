//
//  CollectionViewControllerModel.swift
//  DragNDropPOC
//
//  Created by leonid.mesentsev on 04/03/23.
//

import Foundation
import Combine

final class CollectionViewControllerModel {

    @Published var data: [DataModel] = []

    func loadData() {
        data = [
            DataModel(title: "Card 1", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 2", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 3", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 4", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 5", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 6", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 7", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 8", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 9", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 10", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 11", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 12", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 13", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 14", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 15", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 16", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 17", subtitle: "Lorem ipsum"),
            DataModel(title: "Card 18", subtitle: "Lorem ipsum")
        ]
    }
}
