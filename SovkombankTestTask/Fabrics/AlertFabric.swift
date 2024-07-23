//
//  AlertFabric.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 23.07.2024.
//

import UIKit

struct AlertFabric {
    func createAlert(title: String) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: title, style: .default)
        alert.addAction(action)
        return alert
    }
}
