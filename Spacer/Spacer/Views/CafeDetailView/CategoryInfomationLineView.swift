//
//  InfomationImageAndText.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/24.
//

import UIKit

class CategoryInfomationLineView: UIView {
    
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
    
    private var categoryImageName = ""
    private var categoryName = ""
    
    var selfHeight: CGFloat = 0
    
    init(image: String, discription: String) {
        super.init(frame: CGRect())
        
        icon.image = UIImage(systemName: image)
        self.discription.text = discription
        
        self.addSubview(icon)
        self.addSubview(self.discription)
        
        applyIconConstraints()
        applyDiscriptionConstraints(isCategoryText: false)
    }
     
    init(type: CategoryType, discription: String?) {
        super.init(frame: CGRect())
        
        // icon의 image와 category의 text 내용 설정
        setIconImageAndCategoryText(type: type)
        
        if let discription = discription {
            self.discription.text = discription
        } else {
            self.discription.text = "정보가 없습니다"
            self.discription.textColor = .grayscale4
        }
        
        self.addSubview(icon)
        self.addSubview(category)
        self.addSubview(self.discription)
        
        applyIconConstraints()
        applyCategoryConstraints()
        applyDiscriptionConstraints(isCategoryText: true)
    }
    
    init(type: CategoryType, discription: SNSList) {
        super.init(frame: CGRect())
        
        setIconImageAndCategoryText(type: type)
        
        if let twitterID = discription.twitter {
            setLeftSNSNameRightSNSID(snsName: "twitter", snsID: twitterID)
            selfHeight += 18
        }
        if let instagramID = discription.insta {
            setLeftSNSNameRightSNSID(snsName: "instagram", snsID: instagramID)
            selfHeight += 18
        }
        if let facebookID = discription.insta {
            setLeftSNSNameRightSNSID(snsName: "facebook", snsID: facebookID)
            selfHeight += 18
        }
        
        self.addSubview(icon)
        self.addSubview(category)
        if selfHeight == 0 {
            self.discription.text = "정보가 없습니다"
            self.discription.textColor = .grayscale4
            selfHeight += 20
            self.addSubview(self.discription)
            applyDiscriptionConstraints(isCategoryText: true)
        } else {
            self.addSubview(verticalStackView)
            applyVerticalStackViewConstraints()
        }
        
        applyIconConstraints()
        applyCategoryConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setIconImageAndCategoryText(type: CategoryType) {
        switch type {
        case .location:
            categoryImageName = "LocationIcon"
            categoryName = "위치"
        case .phoneNumber:
            categoryImageName = "callIcon"
            categoryName = "전화번호"
        case .tables:
            categoryImageName = "tableIcon"
            categoryName = "테이블 수"
        case .SNSList:
            categoryImageName = "messageIcon"
            categoryName = "SNS"
        case .operationTime:
            categoryImageName = "timeIcon"
            categoryName = "운영 시간"
        }
        
        icon.image = UIImage(named: categoryImageName)
        category.text = categoryName
    }
    
    private func setLeftSNSNameRightSNSID(snsName: String, snsID: String) {
        let horizontalStackView = UIStackView()
        horizontalStackView.spacing = 6
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .leading
        
        let snsNameLabel = UILabel()
        snsNameLabel.text = snsName
        snsNameLabel.font = .systemFont(for: .body3)
        snsNameLabel.textColor = .grayscale4
        snsNameLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.addArrangedSubview(snsNameLabel)
        
        let snsIDLabel = UILabel()
        snsIDLabel.text = snsID
        snsIDLabel.font = .systemFont(for: .body3)
        snsIDLabel.textColor = .grayscale1
        snsIDLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.addArrangedSubview(snsIDLabel)
        
        verticalStackView.addArrangedSubview(horizontalStackView)
    }

    private func applyIconConstraints() {
        let iconConstraints = [
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            icon.topAnchor.constraint(equalTo: self.topAnchor)
        ]
        
        NSLayoutConstraint.activate(iconConstraints)
    }
    
    private func applyCategoryConstraints() {
        let categoryConstraints = [
            category.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            category.topAnchor.constraint(equalTo: self.topAnchor),
            category.widthAnchor.constraint(equalToConstant: 52),
            category.heightAnchor.constraint(equalToConstant: 20)
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

// 어떤 정보를 나타내는 라인인지 쉽게 알기 위해 enum 타입 생성
enum CategoryType {
    case location
    case phoneNumber
    case tables
    case SNSList
    case operationTime
}
