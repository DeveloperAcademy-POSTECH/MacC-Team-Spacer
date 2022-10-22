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
        
        // 섹션 타이틀을 비율로 넣기 위해서 이곳에서 오토레이아웃 설정함
        let sectionTitleConstraints = [
            sectionTitle.bottomAnchor.constraint(equalTo: bottomAnchor ,constant:  -.padding.underTitlePadding),
            sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.homeMargin)
        ]
        
        let sectionImageConstraints = [
            sectionImage.leadingAnchor.constraint(equalTo: sectionTitle.trailingAnchor, constant: 6),
            sectionImage.centerYAnchor.constraint(equalTo: sectionTitle.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(sectionTitleConstraints)
        NSLayoutConstraint.activate(sectionImageConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
