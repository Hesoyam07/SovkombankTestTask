//
//  Localization.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 21.07.2024.
//

import Foundation

private extension String {
    var localized: String {
        NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
struct Localization {
    static let transacitons = "transactions".localized
    static let products = "Products".localized
    static let gbp = "GBP".localized
    static let total = "Total".localized
    static let transactionFor = "TransactionsFor".localized
    static let decodingFailureDescription = "Decoding failure".localized
    static let dataNotLoadedFailureDescription = "Resource not found".localized
    static let alertOkMessage = "OK".localized
}
