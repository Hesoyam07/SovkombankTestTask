//
//  ViewController.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 20.07.2024.
//

import UIKit

private struct K {
    static let cellId = String(describing: ProductCell.self)
}

final class ProductVC: UIViewController {
    
    private let productVM = ProductVM()
    //MARK: - UI
    private let productTable: UITableView = {
        let t = UITableView()
        t.register(ProductCell.self, forCellReuseIdentifier: K.cellId)
        return t
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        productVM.getData()
        setupView()
        setupConstraints()
        setupTableViewProtocols()
    }
}
//MARK: - Private methods
private extension ProductVC {
    func setupView() {
        view.addSubview(productTable)
        productTable.translatesAutoresizingMaskIntoConstraints = false
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productTable.topAnchor.constraint(equalTo: view.topAnchor),
            productTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func setupTableViewProtocols() {
        productTable.dataSource = self
    }
}
//MARK: - UITableViewDataSource
extension ProductVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cellId, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        let productKey = Array(productVM.products.keys.sorted())[indexPath.row]
        let productValue = productVM.products[productKey] ?? .zero
        cell.configureCell(showDisclosureType: true, primaryText: productKey, secondaryText: productValue)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productVM.products.count
    }
}
