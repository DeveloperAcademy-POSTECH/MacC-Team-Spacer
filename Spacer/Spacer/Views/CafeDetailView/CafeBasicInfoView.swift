//
//  CafeBasicInfoView.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/25.
//

import UIKit

class CafeBasicInfoView: UIView {
    
    let innerMargins: CGFloat = 20

    let cafeTitle: UILabel = {
       let cafeTitle = UILabel()
        cafeTitle.font = .systemFont(for: .header3)
        cafeTitle.textColor = .mainPurple1
        cafeTitle.translatesAutoresizingMaskIntoConstraints = false
        return cafeTitle
    }()
    
    let highlightBox: UIView = {
       let highlightBox = UIView()
        highlightBox.backgroundColor = .subYellow1
        highlightBox.translatesAutoresizingMaskIntoConstraints = false
        return highlightBox
    }()
    
    let starImage: UIImageView = {
       let startImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        startImage.image = UIImage(systemName: "star.fill")
        startImage.tintColor = .systemYellow
        startImage.translatesAutoresizingMaskIntoConstraints = false
        return startImage
    }()
    
    let starRateAndReviewCount: UILabel = {
       let starRateAndReviewCount = UILabel()
        starRateAndReviewCount.font = .systemFont(for: .body2)
        starRateAndReviewCount.textColor = .grayscale2
        starRateAndReviewCount.translatesAutoresizingMaskIntoConstraints = false
        return starRateAndReviewCount
    }()
    
    let favoriteButton: UIButton = {
        let favoriteButton = UIButton(type: .custom)
        favoriteButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        favoriteButton.imageView?.tintColor = .systemRed
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        return favoriteButton
    }()
    
    lazy var addressInfo: InfomationImageAndText = {
        let address = InfomationImageAndText(image: "pin.fill", discription: "")
        address.translatesAutoresizingMaskIntoConstraints = false
        return address
    }()
    
    lazy var peopleCountInfo: InfomationImageAndText = {
        let peopleCount = InfomationImageAndText(image: "person.fill", discription: "")
        peopleCount.translatesAutoresizingMaskIntoConstraints = false
        return peopleCount
    }()
    
    init(title: String, starRate: Double, reviewCount: Int, location: String, min: Int, max: Int) {
        super.init(frame: CGRect())
        
        setStyle()
        
        cafeTitle.text = title
        starRateAndReviewCount.text = "\(starRate) (\(reviewCount))"
        addressInfo.discription.text = location
        peopleCountInfo.discription.text = "\(min)~\(max) 명 동시 수용 가능"
        
        self.addSubview(highlightBox)
        self.addSubview(cafeTitle)
        self.addSubview(starImage)
        self.addSubview(starRateAndReviewCount)
        self.addSubview(favoriteButton)
        self.addSubview(addressInfo)
        self.addSubview(peopleCountInfo)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.1
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 4
        self.layer.cornerRadius = 16
    }
    
    private func applyConstraints() {
        let cafeTitleConstraints = [
            cafeTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: innerMargins),
            cafeTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: innerMargins)
        ]
        
        let highlightBoxConstraints = [
            highlightBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: innerMargins),
            highlightBox.topAnchor.constraint(equalTo: cafeTitle.centerYAnchor, constant: 2),
            highlightBox.widthAnchor.constraint(equalTo: cafeTitle.widthAnchor),
            highlightBox.heightAnchor.constraint(equalToConstant: 13)
        ]
        
        let starImageConstraints = [
            starImage.leadingAnchor.constraint(equalTo: cafeTitle.trailingAnchor, constant: 10),
            starImage.centerYAnchor.constraint(equalTo: cafeTitle.centerYAnchor)
        ]
        
        let starRateAndReviewCountConstraints = [
            starRateAndReviewCount.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 2),
            starRateAndReviewCount.centerYAnchor.constraint(equalTo: starImage.centerYAnchor)
        ]
        
        let favoriteButtonConstraints = [
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -innerMargins),
            favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: innerMargins),
            favoriteButton.widthAnchor.constraint(equalToConstant: 28),
            favoriteButton.heightAnchor.constraint(equalToConstant: 28)
        ]
        
        let addressInfoConstraints = [
            addressInfo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: innerMargins),
            addressInfo.topAnchor.constraint(equalTo: cafeTitle.bottomAnchor, constant: 15),
            addressInfo.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let peopleCountInfoConstraints = [
            peopleCountInfo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: innerMargins),
            peopleCountInfo.topAnchor.constraint(equalTo: addressInfo.bottomAnchor, constant: 10),
            peopleCountInfo.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        NSLayoutConstraint.activate(cafeTitleConstraints)
        NSLayoutConstraint.activate(highlightBoxConstraints)
        NSLayoutConstraint.activate(starImageConstraints)
        NSLayoutConstraint.activate(starRateAndReviewCountConstraints)
        NSLayoutConstraint.activate(favoriteButtonConstraints)
        NSLayoutConstraint.activate(addressInfoConstraints)
        NSLayoutConstraint.activate(peopleCountInfoConstraints)
    }
    
}
