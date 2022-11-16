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
    
    lazy var categoryLabel: UILabel = {
        let category = UILabel()
        category.font = .systemFont(for: .body2)
        category.textColor = .grayscale3
        category.translatesAutoresizingMaskIntoConstraints = false
        return category
    }()
    
    lazy var descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = .systemFont(for: .body3)
        description.textColor = .grayscale1
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
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

    init(type: CategoryType, description: String?) {
        super.init(frame: .zero)
        
        setIconImageAndCategoryText(type: type)
        selfHeight = 20
        
        if let description = description {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = "정보가 없습니다"
            descriptionLabel.textColor = .grayscale4
        }
        
        self.addSubview(icon)
        self.addSubview(categoryLabel)
        self.addSubview(descriptionLabel)
        
        applyIconConstraints()
        applyCategoryConstraints()
        applyDescriptionConstraints(isCategoryText: true)
    }
    
    init(type: CategoryType, description: SNSList) {
        super.init(frame: .zero)
        
        setIconImageAndCategoryText(type: type)
        
        if let twitterID = description.twitter {
            setSubTitleAndDescription(subTitle: "twitter", description: twitterID)
            selfHeight += 18
        }
        if let instagramID = description.insta {
            setSubTitleAndDescription(subTitle: "instagram", description: instagramID)
            selfHeight += 18
        }
        
        self.addSubview(icon)
        self.addSubview(categoryLabel)
        if selfHeight == 0 {
            descriptionLabel.text = "정보가 없습니다"
            descriptionLabel.textColor = .grayscale4
            selfHeight += 20
            self.addSubview(descriptionLabel)
            applyDescriptionConstraints(isCategoryText: true)
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
            setSubTitleAndDescription(subTitle: "평일", description: weekdayTime)
        }
        if weekendTime != "" {
            selfHeight += 18
            setSubTitleAndDescription(subTitle: "주말", description: weekendTime)
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
        self.addSubview(categoryLabel)
        self.addSubview(verticalStackView)
        
        if selfHeight == 0 {
            selfHeight = 20
            self.descriptionLabel.text = "격주로 수요일 휴무"
            applyDescriptionConstraints(isCategoryText: true)
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
        categoryLabel.text = categoryName
    }
    
    private func setSubTitleAndDescription(subTitle: String, description: String) {
        let horizontalStackView = UIStackView()
        horizontalStackView.spacing = 6
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .leading
        
        let subTitleLabel = UILabel()
        subTitleLabel.text = subTitle
        subTitleLabel.font = .systemFont(for: .body3)
        subTitleLabel.textColor = .grayscale3
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.addArrangedSubview(subTitleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
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
            categoryLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            categoryLabel.topAnchor.constraint(equalTo: self.topAnchor),
            categoryLabel.widthAnchor.constraint(equalToConstant: 52),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20)
        ]

        NSLayoutConstraint.activate(categoryConstraints)
    }
    
    private func applyDescriptionConstraints(isCategoryText: Bool) {
        let descriptionConstraints = [
            descriptionLabel.leadingAnchor.constraint(equalTo: isCategoryText ? categoryLabel.trailingAnchor : icon.trailingAnchor, constant: isCategoryText ? 18 : 8),
            descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(descriptionConstraints)
    }
    
    private func applyVerticalStackViewConstraints() {
        let verticalStackViewConstraints = [
            verticalStackView.leadingAnchor.constraint(equalTo: categoryLabel.trailingAnchor, constant: 18),
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
