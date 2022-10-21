//
//  BirthdayCafeTableViewSectionHeader.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/21.
//

import UIKit

class BirthdayCafeTableViewSectionHeader: UITableViewHeaderFooterView {
    
    static let identifier = "BirthdayCafeTableViewSectionHeader"
    
    let sectionTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(for: .header3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sectionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(sectionTitle)
        addSubview(sectionImage)
        
        let sectionImageConstraints = [
            sectionImage.leadingAnchor.constraint(equalTo: sectionTitle.trailingAnchor, constant: 6),
            sectionImage.centerYAnchor.constraint(equalTo: sectionTitle.centerYAnchor)
        ]
        NSLayoutConstraint.activate(sectionImageConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
