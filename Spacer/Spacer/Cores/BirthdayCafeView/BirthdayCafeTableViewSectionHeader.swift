//
//  BirthdayCafeTableViewSectionHeader.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/21.
//

import UIKit

class BirthdayCafeTableViewSectionHeader: UITableViewHeaderFooterView {
    let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(for: .header3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    static let identifier = "BirthdayCafeTableViewSectionHeader"
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(title)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
