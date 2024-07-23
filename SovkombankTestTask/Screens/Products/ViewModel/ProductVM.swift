//
//  ProductVM.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 21.07.2024.
//

import UIKit
private struct K {
    static let transactionsResource = "transactions"
}
final class ProductVM {
    
    var alertFabric: AlertFabric {
        AlertFabric()
    }
    private let dataManager = DataManager()
    private(set) var products = [String: [TransactionModel]]()
    
    func getRates(completion: @escaping ProductResult) {
        dataManager.getData(resource: K.transactionsResource, responseType: TransactionModel.self) { result in
            switch result {
            case .success(let transactions):
                let skuCount = Dictionary(grouping: transactions, by: \.sku)
                self.products = skuCount
                completion(.success(transactions))
            case .failure(let dataError):
                completion(.failure(dataError))
            }
        }
    }
}
