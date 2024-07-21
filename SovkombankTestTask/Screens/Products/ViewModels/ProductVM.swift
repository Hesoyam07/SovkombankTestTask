//
//  ProductVM.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 21.07.2024.
//

import UIKit

final class ProductVM {
    
    private let dataManager = DataManager()
    private(set) var products = [String: Int]()
    func getData() {
        dataManager.getProducts { result in
            switch result {
            case .success(let transactions):
                let skuCount = Dictionary(grouping: transactions, by: \.sku).mapValues({$0.count})
                self.products = skuCount
            case .failure(_):
                break
            }
        }
    }
}
