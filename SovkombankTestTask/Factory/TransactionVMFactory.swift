//
//  TransactionVMFactory.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 23.07.2024.
//

import Foundation

struct TransactionVMFactory {
    static func createTransactionVM(with productVM: ProductVM, and sku: String) -> TransactionsVM {
        TransactionsVM(productVM: productVM, sku: sku)
    }
}
