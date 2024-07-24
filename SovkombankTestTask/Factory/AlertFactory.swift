//
//  AlertFactory.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 23.07.2024.
//

import UIKit

struct AlertFactory {
    static func createAlert(title: String) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: Localization.alertOkMessage, style: .default)
        alert.addAction(action)
        return alert
    }
}
