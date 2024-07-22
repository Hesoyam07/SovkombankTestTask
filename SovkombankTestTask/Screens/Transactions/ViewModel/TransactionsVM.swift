//
//  TransactionsVM.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 21.07.2024.
//

import UIKit

private struct K {
    static let localeIdentifier = "en_US"
}

final class TransactionsVM {
    //MARK: - Properties
    let sku: String
    private let dataManager = DataManager()
    private(set) var rates = [RatesModel]()
    private(set) var convertedCurrencies = [String]()
    private var currencyConverter: CurrencyConverter {
        CurrencyConverter(rates: rates)
    }
    private(set) var transactions: [TransactionModel]
    private(set) var currencies = [String]()
    private let productVM: ProductVM
    //MARK: - Initializer
    init(productVM: ProductVM, sku: String) {
        self.productVM = productVM
        self.sku = sku
        self.transactions = productVM.products[sku]!
    }
    //MARK: - Methods
    func calculateTotalAmount() -> Float {
        let sum = convertedCurrencies.map { Float($0) ?? .zero}.reduce(0, +)
        return sum
    }
    func currencyNameToSymbol() {
        transactions.forEach({
            let locale = Locale(identifier: K.localeIdentifier)
            let currencyCode = $0.currency
            let formatter = NumberFormatter()
            formatter.locale = locale
            formatter.currencyCode = currencyCode
            if let currencySymbol = formatter.currencySymbol {
                currencies.append(currencySymbol)
            }
        })
    }
    func convertTransactions() {
        transactions.forEach({
            let currency = currencyConverter.convert(transaction: $0)
            convertedCurrencies.append(currency)
        })
    }
    func getRates() {
        dataManager.getRates { result in
            switch result {
            case .success(let rates):
                self.rates = rates
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
