//
//  DataManager.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 20.07.2024.
//

import UIKit

enum DataError: Error {
    case dataNotLoaded(description: String)
    case decodingFailure(description: String)
}
private struct K {
    static let fileExtension = "plist"
    static let transactions = "transactions"
    static let rates = "rates"
    static let decodingFailureDescription = "Decoding failure"
}
final class DataManager {
    func getProducts(completion: @escaping (Result<[TransactionModel], DataError>) -> Void) {
        if let url = Bundle.main.url(forResource: K.transactions, withExtension: K.fileExtension) {
            do {
                let decoder = PropertyListDecoder()
                let data = try Data(contentsOf: url)
                let transactions = try decoder.decode([TransactionModel].self, from: data)
                completion(.success(transactions))
            } catch {
                completion(.failure(.decodingFailure(description: K.decodingFailureDescription)))
            }
        }
    }
    func getRates(completion: @escaping ((Result<[RatesModel], DataError>) -> Void)) {
        if let url = Bundle.main.url(forResource: K.rates, withExtension: K.fileExtension) {
            do {
                let decoder = PropertyListDecoder()
                let data = try Data(contentsOf: url)
                let rates = try decoder.decode([RatesModel].self, from: data)
                completion(.success(rates))
            } catch {
                completion(.failure(.decodingFailure(description: K.decodingFailureDescription)))
            }
        }
    }
}
