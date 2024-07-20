//
//  TransactionsModel.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 20.07.2024.
//

import UIKit

struct TransactionModel: Decodable {
    let amount: String
    let currency: String
    let sku: String
}
