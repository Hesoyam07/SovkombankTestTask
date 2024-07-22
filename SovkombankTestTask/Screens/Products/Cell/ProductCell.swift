//
//  ProductCell.swift
//  SovkombankTestTask
//
//  Created by Дмитрий on 21.07.2024.
//

import UIKit

final class ProductCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureCell(showDisclosureType: Bool, primaryText: String, secondaryText: String) {
        var config = defaultContentConfiguration()
        config.text = primaryText
        config.secondaryText = showDisclosureType ? "\(String(secondaryText)) \(Localization.transacitons)" : "\(String(secondaryText))"
        contentConfiguration = config
        accessoryType =  showDisclosureType ? .disclosureIndicator : .none
    }
}
