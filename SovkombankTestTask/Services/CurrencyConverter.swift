//
//  ConverterService.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 22.07.2024.
//

import Foundation

private struct K {
    static let pounds = "GBP"
}

struct CurrencyConverter {
    private let rates: [RatesModel]
    static private let poundsSymbol = K.pounds
    init(rates: [RatesModel]) {
        self.rates = rates
    }
    func convert(transaction: TransactionModel) -> String {
        guard transaction.currency != Self.poundsSymbol else {
            return "\(transaction.amount)"
        }
        if let poundRate = rates.filter({ $0.from == transaction.currency && $0.to == Self.poundsSymbol }).first {
            return  String(format: "%.2f", (Float(transaction.amount) ?? .zero) * (Float(poundRate.rate) ?? .zero))
        }
        var availablePoundRates = rates.filter { $0.to == Self.poundsSymbol }
        guard let transactionCurrencyRate = availablePoundRates.first else { return "" }
        availablePoundRates = rates.filter { $0.from == transaction.currency && $0.to == transactionCurrencyRate.from }
        let transaction1Rate = Float(availablePoundRates.first?.rate ?? "") ?? .zero
        let transaction2Rate = Float(transactionCurrencyRate.rate) ?? .zero
        let calculatedRate = transaction1Rate == transaction1Rate ? transaction1Rate : transaction2Rate/transaction1Rate
        let result = calculatedRate * (Float(transaction.amount) ?? .zero)
        let roundedResult = String(format: "%.2f", result)
        return roundedResult
        
    }
}
