//
//  BirthdayCafeTableViewSectionHeader.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/21.
//

import UIKit

class BirthdayCafeTableViewSectionHeader: UITableViewHeaderFooterView {

    static let identifier = "BirthdayCafeTableViewSectionHeader"
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
