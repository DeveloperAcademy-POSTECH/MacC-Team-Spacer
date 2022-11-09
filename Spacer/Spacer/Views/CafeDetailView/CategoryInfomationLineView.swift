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

    init(type: CategoryType, discription: String?) {
        super.init(frame: .zero)
        
        setIconImageAndCategoryText(type: type)
        selfHeight = 20
        
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
        super.init(frame: .zero)
        
        setIconImageAndCategoryText(type: type)
        
        if let twitterID = discription.twitter {
            setSubTitleAndDescription(subTitle: "twitter", discription: twitterID)
            selfHeight += 18
        }
        if let instagramID = discription.insta {
            setSubTitleAndDescription(subTitle: "instagram", discription: instagramID)
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
    
    init(type: CategoryType, weekdayTime: String, weekendTime: String, dayOff: String?) {
        super.init(frame: .zero)
        
        setIconImageAndCategoryText(type: type)
        
        if weekdayTime != "" {
            selfHeight += 18
            setSubTitleAndDescription(subTitle: "평일", discription: weekdayTime)
        }
        if weekendTime != "" {
            selfHeight += 18
            setSubTitleAndDescription(subTitle: "주말", discription: weekendTime)
        }
        if let dayOffText = dayOff {
            selfHeight += 18
            let offLabel = UILabel()
            offLabel.text = dayOffText
            offLabel.textColor = .grayscale3
            offLabel.font = .systemFont(for: .body3)
            verticalStackView.addArrangedSubview(offLabel)
        }
        
        self.addSubview(icon)
        self.addSubview(category)
        self.addSubview(verticalStackView)
        
        if selfHeight == 0 {
            selfHeight = 20
            self.discription.text = "격주로 수요일 휴무"
            applyDiscriptionConstraints(isCategoryText: true)
        } else {
            applyVerticalStackViewConstraints()
        }
        
        applyIconConstraints()
        applyCategoryConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // icon의 image와 category의 text 내용 설정
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
    
    private func setSubTitleAndDescription(subTitle: String, discription: String) {
        let horizontalStackView = UIStackView()
        horizontalStackView.spacing = 6
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .leading
        
        let subTitleLabel = UILabel()
        subTitleLabel.text = subTitle
        subTitleLabel.font = .systemFont(for: .body3)
        subTitleLabel.textColor = .grayscale4
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.addArrangedSubview(subTitleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = discription
        descriptionLabel.font = .systemFont(for: .body3)
        descriptionLabel.textColor = .grayscale1
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.addArrangedSubview(descriptionLabel)
        
        verticalStackView.addArrangedSubview(horizontalStackView)
    }

    private func applyIconConstraints() {
        let iconConstraints = [
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            icon.topAnchor.constraint(equalTo: self.topAnchor),
            icon.heightAnchor.constraint(equalToConstant: 20),
            icon.widthAnchor.constraint(equalToConstant: 20)
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
