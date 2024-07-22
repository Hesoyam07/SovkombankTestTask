//
//  TransactionsVC.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 21.07.2024.
//

import UIKit

private struct K {
    static let cellId = String(describing: ProductCell.self)
}

final class TransactionsVC: UIViewController {
    
    private let transactionVM: TransactionsVM

    //MARK: Initialiser
    init(transactionVM: TransactionsVM) {
        self.transactionVM = transactionVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - UI
    private let transactionsTable: UITableView = {
        let t = UITableView()
        t.register(ProductCell.self, forCellReuseIdentifier: K.cellId)
        return t
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionVM.getRates()
        transactionVM.currencyNameToSymbol()
        transactionVM.convertTransactions()
        setupView()
        setupConstraints()
        setupTableViewProtocols()
        setupNavBar()
    }
}
//MARK: - Private methods
private extension TransactionsVC {
    func setupView() {
        view.addSubview(transactionsTable)
        transactionsTable.translatesAutoresizingMaskIntoConstraints = false
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            transactionsTable.topAnchor.constraint(equalTo: view.topAnchor),
            transactionsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            transactionsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            transactionsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func setupTableViewProtocols() {
        transactionsTable.dataSource = self
    }
    func setupNavBar() {
        title = "\(Localization.transactionFor) \(transactionVM.sku)"
    }
}
//MARK: - UITableViewDataSource
extension TransactionsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "\(Localization.total) \(Localization.gbp)\(String(describing: transactionVM.calculateTotalAmount()))"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactionVM.transactions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cellId, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        let primaryText = "\(transactionVM.currencies[indexPath.row]) \(transactionVM.transactions.map({$0.amount})[indexPath.row])"
        let secondaryText = "\(Localization.gbp) \(transactionVM.convertedCurrencies[indexPath.row])"
        cell.configureCell(showDisclosureType: false, primaryText: primaryText, secondaryText: secondaryText )
        
        return cell
    }
}
