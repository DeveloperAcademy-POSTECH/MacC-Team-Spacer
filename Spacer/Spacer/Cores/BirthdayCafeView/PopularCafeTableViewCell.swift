//
//  PopularCafeTableViewCell.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/11.
//

import UIKit

class PopularCafeTableViewCell: UITableViewCell {
    
    static let identifier = "PopularCafeTableViewCell"
    
    // 카페 이미지
    private let CafeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // 그라디언트
    let gradientLayer = CAGradientLayer()
    
    // 카페 이름
    private let cafeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .header4)
        label.textColor = .grayscale6
        return label
    }()
    
    // 카페 별점
    private let cafeStarRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body1)
        label.textColor = .grayscale6
        return label
    }()
    
    // 카페 별점 이미지
    private let cafeStarRatingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "StarRatingIcon")
        return imageView
    }()
    
    // 카페 위치
    private let cafeLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body1)
        label.textColor = .grayscale6
        return label
    }()
    
    // 카페 위치 이미지
    private let cafeLocationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "LocationIcon")
        return imageView
    }()

    
    // 카페 인원수
    private let cafePeople: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body1)
        label.textColor = .grayscale6
        return label
    }()
    
    // 카페 인원수 이미지
    private let cafePeopleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "CafePeopleIcon")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(CafeImageView)
        contentView.addSubview(cafeName)
        contentView.addSubview(cafeStarRating)
        contentView.addSubview(cafeStarRatingImage)
        contentView.addSubview(cafeLocation)
        contentView.addSubview(cafeLocationImage)
        contentView.addSubview(cafePeople)
        contentView.addSubview(cafePeopleImage)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let cafeNameConstraints = [
            cafeName.leadingAnchor.constraint(equalTo: CafeImageView.leadingAnchor, constant: .padding.bigBoxPadding),
            cafeName.bottomAnchor.constraint(equalTo: cafeStarRating.topAnchor, constant: -.padding.bigBoxTextPadding),
        ]
        
        let cafeStarRatingConstraints = [
            cafeStarRating.leadingAnchor.constraint(equalTo: cafeStarRatingImage.trailingAnchor, constant: .padding.betweenIconPadding),
            cafeStarRating.bottomAnchor.constraint(equalTo: CafeImageView.bottomAnchor, constant: -.padding.bigBoxPadding)
        ]
        
        let cafeStarRatingImageConstraints = [
            cafeStarRatingImage.leadingAnchor.constraint(equalTo: CafeImageView.leadingAnchor, constant: .padding.bigBoxPadding),
            cafeStarRatingImage.centerYAnchor.constraint(equalTo: cafeStarRating.centerYAnchor),
            cafeStarRatingImage.heightAnchor.constraint(equalToConstant: 18),
            cafeStarRatingImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        let cafeLocationConstraints = [
            cafeLocation.trailingAnchor.constraint(equalTo: cafePeopleImage.leadingAnchor, constant: -.padding.bigBoxPadding),
            cafeLocation.bottomAnchor.constraint(equalTo: cafePeople.bottomAnchor),
        ]
        
        let cafeLocationImageConstraints = [
            cafeLocationImage.trailingAnchor.constraint(equalTo: cafeLocation.leadingAnchor, constant: -.padding.betweenIconPadding),
            cafeLocationImage.centerYAnchor.constraint(equalTo: cafeLocation.centerYAnchor),
            cafeLocationImage.heightAnchor.constraint(equalToConstant: 18),
            cafeLocationImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        let cafePeopleConstraints = [
            cafePeople.trailingAnchor.constraint(equalTo: CafeImageView.trailingAnchor, constant: -.padding.bigBoxPadding),
            cafePeople.bottomAnchor.constraint(equalTo: cafeStarRating.bottomAnchor)
        ]
        
        let cafePeopleImageConstraints = [
            cafePeopleImage.trailingAnchor.constraint(equalTo: cafePeople.leadingAnchor, constant: -.padding.betweenIconPadding),
            cafePeopleImage.centerYAnchor.constraint(equalTo: cafePeople.centerYAnchor),
            cafePeopleImage.heightAnchor.constraint(equalToConstant: 18),
            cafePeopleImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        NSLayoutConstraint.activate(cafeNameConstraints)
        NSLayoutConstraint.activate(cafeStarRatingConstraints)
        NSLayoutConstraint.activate(cafeStarRatingImageConstraints)
        NSLayoutConstraint.activate(cafeLocationConstraints)
        NSLayoutConstraint.activate(cafeLocationImageConstraints)
        NSLayoutConstraint.activate(cafePeopleConstraints)
        NSLayoutConstraint.activate(cafePeopleImageConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        // TODO: - 사샤에게 패딩 컨펌받기
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: .padding.betweenContentsPadding/2, left: .padding.homeMargin, bottom: .padding.betweenContentsPadding/2, right: .padding.homeMargin))
        
        NSLayoutConstraint.activate([
            CafeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            CafeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            CafeImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            CafeImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
        ])
        
        let colorSet = [
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0),
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0),
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4),
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)

        ]
        
        let location = [0.0, 0.5, 0.7]
        
        let startEndPoint = (CGPoint(x: 0, y: 0),CGPoint(x: 0, y: 1))
        
        CafeImageView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location,startEndPoints: startEndPoint)
        
    }
    
    // MARK: - 1. cafeInfo를 받아와서 셀에 값을 넣어줌
    
    public func configure(with model: CafeInfoModel) {
        self.cafeName.text = model.cafeName
        self.CafeImageView.image = UIImage(named: model.imageDirectories[0])
        self.cafeStarRating.text = String(model.cafeStarRating)
        
        
        let longCafeAddress = model.cafeAddress.components(separatedBy: " ")
        var shortCafeAddress = "\(longCafeAddress[0]) \(longCafeAddress[1])"
        self.cafeLocation.text = shortCafeAddress
        
        // 둘 중 하나의 값이 없으면 - 표시
        if let cafeMinPeople = model.cafeMinPeople, let cafeMaxPeople = model.cafeMinPeople {
            self.cafePeople.text = "\(cafeMinPeople) ~ \(cafeMaxPeople)"
        } else {
            self.cafePeople.text = "-"
        }
        
    }
    
    // MARK: - layer에다 그라디언트 추가하기
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        gradientLayer.frame = contentView.bounds
    }
}


