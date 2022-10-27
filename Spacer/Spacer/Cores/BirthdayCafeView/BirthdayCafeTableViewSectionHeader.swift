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
    
    let titleUnderLine: UIView = {
        let line = UIView()
        line.backgroundColor = .subYellow1
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(titleUnderLine)
        titleUnderLine.addSubview(sectionTitle)
        addSubview(sectionImage)
        
        let titleUnderLineConstraints = [
            titleUnderLine.topAnchor.constraint(equalTo: sectionTitle.topAnchor, constant: 14),
            titleUnderLine.leadingAnchor.constraint(equalTo: sectionTitle.leadingAnchor),
            titleUnderLine.trailingAnchor.constraint(equalTo: sectionTitle.trailingAnchor),
            titleUnderLine.heightAnchor.constraint(equalToConstant: 13)
        ]
        
        let sectionTitleConstraints = [
            sectionTitle.bottomAnchor.constraint(equalTo: bottomAnchor ,constant:  -.padding.underTitlePadding),
            sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.homeMargin)
        ]
        
        let sectionImageConstraints = [
            sectionImage.leadingAnchor.constraint(equalTo: sectionTitle.trailingAnchor, constant: 6),
            sectionImage.topAnchor.constraint(equalTo: sectionTitle.topAnchor),
            sectionImage.heightAnchor.constraint(equalToConstant: 30),
            sectionImage.widthAnchor.constraint(equalToConstant: 30)
        ]
        
        NSLayoutConstraint.activate(titleUnderLineConstraints)
        NSLayoutConstraint.activate(sectionTitleConstraints)
        NSLayoutConstraint.activate(sectionImageConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
