//
//  ProductVM.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 21.07.2024.
//

import UIKit

final class ProductVM {
    
    private let dataManager = DataManager()
    private(set) var products = [String: [TransactionModel]]()
    func getData(completion: @escaping () -> Void) {
        dataManager.getProducts { result in
            switch result {
            case .success(let transactions):
                let skuCount = Dictionary(grouping: transactions, by: \.sku)
                self.products = skuCount
                completion()
            case .failure(_):
                break
            }
        }
    }
}
