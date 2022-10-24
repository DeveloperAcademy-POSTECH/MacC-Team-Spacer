//
//  InfomationImageAndText.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/24.
//

import UIKit

class InfomationImageAndText: UIView {
    
    lazy var icon: UIImageView = {
        let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        icon.tintColor = .mainPurple4
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var category: UILabel = {
        let category = UILabel()
        category.font = .systemFont(for: .body3)
        category.textColor = .grayscale1
        category.translatesAutoresizingMaskIntoConstraints = false
        return category
    }()
    
    lazy var discription: UILabel = {
        let discription = UILabel()
        discription.font = .systemFont(for: .body3)
        discription.textColor = .grayscale1
        discription.translatesAutoresizingMaskIntoConstraints = false
        return discription
    }()
    
    init(image: String, discription: String) {
        super.init(frame: CGRect())
        
        icon.image = UIImage(systemName: image)
        self.discription.text = discription
        
        self.addSubview(icon)
        self.addSubview(self.discription)
        
        applyIconConstraints()
        applyDiscriptionConstraints(isCategoryText: false)
    }
     
    init(image: String, category: String, discription: String) {
        super.init(frame: CGRect())
        
        icon.image = UIImage(systemName: image)
        self.category.text = category
        self.discription.text = discription
        
        self.addSubview(icon)
        self.addSubview(self.category)
        self.addSubview(self.discription)
        
        applyIconConstraints()
        applyCategoryConstraints()
        applyDiscriptionConstraints(isCategoryText: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func applyIconConstraints() {
        let iconConstraints = [
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(iconConstraints)
    }
    
    private func applyCategoryConstraints() {
        let categoryConstraints = [
            category.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            category.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            category.widthAnchor.constraint(equalToConstant: 52)
        ]

        NSLayoutConstraint.activate(categoryConstraints)
    }
    
    private func applyDiscriptionConstraints(isCategoryText: Bool) {
        let discriptionConstraints = [
            discription.leadingAnchor.constraint(equalTo: isCategoryText ? category.trailingAnchor : icon.trailingAnchor, constant: isCategoryText ? 18 : 8),
            discription.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(discriptionConstraints)
    }


}
