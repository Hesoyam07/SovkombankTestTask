//
//  DataManager.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 20.07.2024.
//

import UIKit

typealias ProductResult = (Result<[TransactionModel], DataError>) -> Void
typealias RateResult = (Result<[Void], DataError>) -> Void
typealias DataResult<T: Decodable> = (Result<[T], DataError>) -> Void

//MARK: - Custom errors
enum DataError: Error {
    case dataNotLoaded(description: String)
    case decodingFailure(description: String)
}
//MARK: - Constants
private struct K {
    static let fileExtension = "plist"
}

final class DataManager {
    //MARK: - Methods
    func getData<T: Decodable>(resource: String, responseType: T.Type, completion: @escaping DataResult<T>) {
        if let url = Bundle.main.url(forResource: resource, withExtension: K.fileExtension) {
            do {
                let decoder = PropertyListDecoder()
                let data = try Data(contentsOf: url)
                let models = try decoder.decode([T].self, from: data)
                completion(.success(models))
            } catch {
                completion(.failure(.decodingFailure(description: Localization.decodingFailureDescription)))
            }
        } else {
            completion(.failure(.dataNotLoaded(description: Localization.dataNotLoadedFailureDescription)))
        }
    }
}
