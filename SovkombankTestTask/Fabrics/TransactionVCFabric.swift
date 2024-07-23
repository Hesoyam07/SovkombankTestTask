//
//  TransactionVCFabric.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 23.07.2024.
//

import Foundation

struct TransactionVCFabric {
    static func createTransactionVC(viewModel: TransactionsVM) -> TransactionsVC {
        TransactionsVC(transactionVM: viewModel)
    }
}
