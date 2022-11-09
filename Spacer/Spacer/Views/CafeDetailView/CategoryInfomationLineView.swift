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
     
    init(image: String, category: String, discription: String?) {
        super.init(frame: CGRect())
        
        icon.image = UIImage(systemName: image)
        self.category.text = category
        
        // TODO: 데이터에서 전화 번호 옵셔널 삭제한 후 코드 변경 필요
        if let discription = discription {
            self.discription.text = discription
        } else {
            self.discription.text = "전화번호가 없습니다"
            self.discription.textColor = .grayscale4
        }
        
        self.addSubview(icon)
        self.addSubview(self.category)
        self.addSubview(self.discription)
        
        applyIconConstraints()
        applyCategoryConstraints()
        applyDiscriptionConstraints(isCategoryText: true)
    }
    
    init(image: String, category: String, discription: SNSList) {
        super.init(frame: CGRect())
        
        icon.image = UIImage(systemName: image)
        self.category.text = category
        
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
        self.addSubview(self.category)
        if selfHeight == 0 {
            self.discription.text = "SNS 정보가 없습니다"
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
