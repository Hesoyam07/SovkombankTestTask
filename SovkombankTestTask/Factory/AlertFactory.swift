//
//  AlertFactory.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 23.07.2024.
//

import UIKit
private struct K {
    static let alertOkMessage = "OK"
}

struct AlertFactory {
    static func createAlert(title: String) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: K.alertOkMessage, style: .default)
        alert.addAction(action)
        return alert
    }
}
