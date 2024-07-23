//
//  TransactionsVM.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 21.07.2024.
//

import UIKit

private struct K {
    static let localeIdentifier = "en_US"
    static let ratesResource = "rates"
}

final class TransactionsVM {
    
    //MARK: - Properties
    let sku: String
    var alertFabric: AlertFabric {
        AlertFabric()
    }
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
        self.transactions = productVM.products[sku] ?? [TransactionModel(amount: "", currency: "", sku: "")]
    }
    //MARK: - Methods
    func convertCurrencies() {
        convertTransactions()
        convertCurrencyToSymbol()
    }
    func calculateTotalAmount() -> String {
        let sum = convertedCurrencies.compactMap { Double($0) }.reduce(0, +)
        return String(format: "%.2f", sum)
    }
    func getRates(completion: @escaping RateResult) {
        dataManager.getData(resource: K.ratesResource, responseType: RatesModel.self) { result in
            switch result {
            case .success(let rates):
                self.rates = rates
                completion(.success(rates))
            case .failure(let dataError):
                completion(.failure(dataError))
            }
        }
    }
}
//MARK: - Private mehods
private extension TransactionsVM {
    private func convertCurrencyToSymbol() {
        let locale = Locale(identifier: K.localeIdentifier)
        let formatter = NumberFormatter()
        formatter.locale = locale
        transactions.forEach({
            let currencyCode = $0.currency
            formatter.currencyCode = currencyCode
            if let currencySymbol = formatter.currencySymbol {
                currencies.append(currencySymbol)
            }
        })
    }
    private func convertTransactions() {
        transactions.forEach({
            let currency = currencyConverter.convert(transaction: $0)
            convertedCurrencies.append(currency)
        })
    }
}
