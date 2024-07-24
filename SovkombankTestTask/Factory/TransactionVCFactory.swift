//
//  TransactionVCFactory.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 23.07.2024.
//

import Foundation

struct TransactionVCFactory {
    static func createTransactionVC(with productVM: ProductVM, and sku: String) -> TransactionsVC {
        let viewModel = TransactionVMFactory.createTransactionVM(with: productVM, and: sku)
        return TransactionsVC(transactionVM: viewModel)
    }
}
