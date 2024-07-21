//
//  TransactionsVM.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 21.07.2024.
//

import UIKit

final class TransactionsVM {
    let sku: String
    private(set) var transactions: [TransactionModel]
    private(set) var currencies = [String]()
    private let productVM: ProductVM
    init(productVM: ProductVM, sku: String) {
        self.productVM = productVM
        self.sku = sku
        self.transactions = productVM.products[sku]!
    }
    func currencyNameToSymbol() {
        transactions.forEach({
            let locale = Locale(identifier: "en_US")
            let currencyCode = $0.currency
            let formatter = NumberFormatter()
            formatter.locale = locale
            formatter.currencyCode = currencyCode
            if let currencySymbol = formatter.currencySymbol {
                currencies.append(currencySymbol)
            }
        })
    }
}
