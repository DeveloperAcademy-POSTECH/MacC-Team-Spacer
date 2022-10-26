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
    
    lazy var verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.spacing = 2
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackView
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
    
    init(image: String, category: String, discription: [String: String]) {
        super.init(frame: CGRect())
        
        icon.image = UIImage(systemName: image)
        self.category.text = category
        
        // sns 이름과 sns 아이디를 생성
        let sortedDiscription = discription.sorted { $0.0 > $1.0 }
        for (snsName, snsID) in sortedDiscription {
            let horizentalStackView = UIStackView()
            horizentalStackView.spacing = 6
            horizentalStackView.axis = .horizontal
            horizentalStackView.alignment = .leading
            
            let sns = UILabel()
            sns.text = snsName
            sns.font = .systemFont(for: .body3)
            sns.textColor = .grayscale4
            sns.translatesAutoresizingMaskIntoConstraints = false
            horizentalStackView.addArrangedSubview(sns)
            
            let snsID = UILabel()
            snsID.text = snsID
            snsID.font = .systemFont(for: .body3)
            snsID.textColor = .grayscale1
            snsID.translatesAutoresizingMaskIntoConstraints = false
            horizentalStackView.addArrangedSubview(snsID)
            
            verticalStackView.addArrangedSubview(horizentalStackView)
        }
        
        self.addSubview(icon)
        self.addSubview(self.category)
        self.addSubview(self.discription)
        self.addSubview(verticalStackView)
        
        applyIconConstraints()
        applyCategoryConstraints()
        applyVerticalStackViewConstraints()
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
    
    private func applyVerticalStackViewConstraints() {
        let verticalStackViewConstraints = [
            verticalStackView.leadingAnchor.constraint(equalTo: category.trailingAnchor, constant: 18),
            verticalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(verticalStackViewConstraints)
    }

}
