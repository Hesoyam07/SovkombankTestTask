//
//  DataManager.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 20.07.2024.
//

import UIKit

typealias DataManagerResult = (Result<[TransactionModel], DataError>) -> Void

enum DataError: Error {
    case dataNotLoaded(description: String)
    case decodingFailure(description: String)
}
private struct K {
    static let fileExtension = "plist"
    static let transactions = "transactions"
}
final class DataManager {
    func getProducts(completion: @escaping DataManagerResult) {
        if let url = Bundle.main.url(forResource: K.transactions, withExtension: K.fileExtension) {
            do {
                let decoder = PropertyListDecoder()
                let data = try Data(contentsOf: url)
                let transactions = try decoder.decode([TransactionModel].self, from: data)
                completion(.success(transactions))
            } catch {
                completion(.failure(.decodingFailure(description: "Decoding failure")))
            }
        }
    }
    
}
