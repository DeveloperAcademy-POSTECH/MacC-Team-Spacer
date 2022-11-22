//
//  MemberCollectionViewCell.swift
//  Spacer
//
//  Created by 허다솔 on 2022/11/22.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    static let identifier = "MemberCollectionViewCell"
    
    lazy var colorBackground: UIView = {
        let UIView = UIView()
        UIView.backgroundColor = .cyan
        UIView.layer.cornerRadius = 24
        UIView.clipsToBounds = true
        UIView.translatesAutoresizingMaskIntoConstraints = false
        return UIView
    }()
    
    lazy var memberImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var memberName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .mainPurple1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var memberPosition: UILabel = {
        let label = UILabel()
        label.font = .systemFont(for: .caption)
        label.textColor = .grayscale3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var myStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(colorBackground)
        addSubview(memberImage)
        
        colorBackground.addSubview(memberName)
        colorBackground.addSubview(memberPosition)
        colorBackground.addSubview(myStack)
        
        NSLayoutConstraint.activate([
            colorBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorBackground.topAnchor.constraint(equalTo: topAnchor),
            colorBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            colorBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            
            memberImage.centerXAnchor.constraint(equalTo: colorBackground.leadingAnchor),
            memberImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            memberImage.widthAnchor.constraint(equalToConstant: 100),
            memberImage.heightAnchor.constraint(equalToConstant: 100),
            
            memberName.topAnchor.constraint(equalTo: topAnchor ,constant: 20),
            memberName.leadingAnchor.constraint(equalTo: colorBackground.leadingAnchor, constant: 79),
            
            memberPosition.topAnchor.constraint(equalTo: memberName.bottomAnchor ,constant: 6),
            memberPosition.leadingAnchor.constraint(equalTo: colorBackground.leadingAnchor, constant: 79),
            
            myStack.topAnchor.constraint(equalTo: memberPosition.bottomAnchor, constant: 12),
            myStack.leadingAnchor.constraint(equalTo: colorBackground.leadingAnchor, constant: 79),
        ])
    }
    
    //TODO: - 값을 넘겨받음
    func configure(backgroundColor: UIColor, memberImage: String, memberName: String, memberPosition: String, firstLabel: String, secondIcon: String, secondLabel: String) {
        self.colorBackground.backgroundColor = backgroundColor
        self.memberImage.image = UIImage(named: memberImage)
        self.memberName.text = memberName
        self.memberPosition.text = memberPosition
        self.myStack.addArrangedSubview(IconLabelView(icon: "emailIcon", label: firstLabel))
        self.myStack.addArrangedSubview(IconLabelView(icon: secondIcon, label: secondLabel))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}
