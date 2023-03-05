//
//  CollectionViewController.swift
//  DragNDropPOC
//
//  Created by leonid.mesentsev on 04/03/23.
//

import UIKit
import Combine

final class CollectionViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    var tableDatasource: TableViewDatasource?
    var collectionDatasource: CollectionViewDatasource?
    private let viewModel = CollectionViewControllerModel()
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Public Methods
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupTableView()
        setupCollectionView()
        setupDatasources()
        setupObservers()
        viewModel.loadData()
    }

    // MARK: - Private Methods
    private func setupStyle() {
        tableContainer.layer.cornerRadius = 10.0
        tableContainer.layer.borderWidth  = 1.0
        tableContainer.layer.borderColor  = UIColor.blue.cgColor
    }

    private func setupTableView() {
        tableView.dropDelegate           = self
        // Seguenti due righe servono solo se vuoi che anche la tabella sia draggabile
        tableView.dragDelegate           = self
        tableView.dragInteractionEnabled = true
    }

    private func setupCollectionView() {
        collectionView.delegate     = self
        collectionView.dragDelegate = self
    }

    private func setupDatasources() {
        // Per i principi SOLID tieni sempre i datasource all'esterno di ViewController,
        // lavorare con i dati non e' un compito suo.
        tableDatasource      = TableViewDatasource(tableView)
        collectionDatasource = CollectionViewDatasource(collectionView)
    }

    private func setupObservers() {
        viewModel.$data
            .receive(on: DispatchQueue.main) // apply di un DiffableDataSource deve stare in main thread
            .sink { [weak self] data in
                self?.collectionDatasource?.setData(data)
        }.store(in: &subscriptions)
    }

    // Usa deinit per controllare che non abbiamo creato retain cycles e
    // il controller viene deallocato quando fai Back o lo chiudi.
    deinit {
        print("\(self) deallocated")
    }
}
