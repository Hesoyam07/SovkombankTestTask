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
        productVM.getData(completion:{ self.productTable.reloadData()})
        setupView()
        setupConstraints()
        setupTableViewProtocols()
        setupNavBar()
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
        productTable.delegate = self
    }
    func setupNavBar() {
        title = Localization.products
    }
}
//MARK: - UITableViewDataSource
extension ProductVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cellId, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        let productKey = Array(productVM.products.keys.sorted())[indexPath.row]
        let productValue = String(productVM.products[productKey]?.count ?? .zero)
        cell.configureCell(showDisclosureType: true, primaryText: productKey, secondaryText: productValue)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productVM.products.count
    }
}
//MARK: - UITableViewDelegate
extension ProductVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subject = Array(productVM.products.keys.sorted())[indexPath.row]
        let vm = TransactionsVM(productVM: productVM, sku: subject)
        let vc = TransactionsVC(transactionVM: vm)
        navigationController?.show(vc, sender: self)
    }
}
