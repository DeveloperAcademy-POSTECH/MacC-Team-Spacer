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
        imageView.contentMode = .scaleAspectFit
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
        imageView.image = UIImage(systemName: "star")
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
        imageView.image = UIImage(systemName: "location")
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
        imageView.image = UIImage(systemName: "person")
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
            cafeStarRatingImage.bottomAnchor.constraint(equalTo: CafeImageView.bottomAnchor, constant: -.padding.bigBoxPadding)
        ]
        
        let cafeLocationConstraints = [
            cafeLocation.trailingAnchor.constraint(equalTo: cafePeopleImage.leadingAnchor, constant: -.padding.bigBoxPadding),
            cafeLocation.bottomAnchor.constraint(equalTo: cafePeople.bottomAnchor),
        ]
        
        let cafeLocationImageConstraints = [
            cafeLocationImage.trailingAnchor.constraint(equalTo: cafeLocation.leadingAnchor, constant: -.padding.betweenIconPadding),
            cafeLocationImage.bottomAnchor.constraint(equalTo: cafePeople.bottomAnchor),
        ]
        
        let cafePeopleConstraints = [
            cafePeople.trailingAnchor.constraint(equalTo: CafeImageView.trailingAnchor, constant: -.padding.bigBoxPadding),
            cafePeople.bottomAnchor.constraint(equalTo: cafeStarRating.bottomAnchor)
        ]
        
        let cafePeopleImageConstraints = [
            cafePeopleImage.trailingAnchor.constraint(equalTo: cafePeople.leadingAnchor, constant: -.padding.betweenIconPadding),
            cafePeopleImage.bottomAnchor.constraint(equalTo: cafeStarRating.bottomAnchor)
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
    
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: .padding.homeMargin, bottom: .padding.betweenContentsPadding, right: .padding.homeMargin))
        
        NSLayoutConstraint.activate([
            CafeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            CafeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            CafeImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            CafeImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
        ])
        
        let colorSet = [
           UIColor(white: 0, alpha: 0),
           UIColor(white: 0, alpha: 0.6),
           UIColor(white: 0, alpha: 0.8)
        ]
        
        let location = [0.5,0.7,1.0]
        
        CafeImageView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
        
    }
    
    // MARK: - 1. cafeInfo를 받아와서 셀에 값을 넣어줌
    
    public func configure(with model: CafeInfo) {
        self.cafeName.text = model.cafe_name
        self.CafeImageView.image = UIImage(named: model.image_directories[0])
        self.cafeStarRating.text = String(model.cafe_star_rating)
        self.cafeLocation.text = String(model.location_id) + "지역"
        self.cafePeople.text = "\(model.cafe_min_people) ~ \(model.cafe_max_people)"
    }
    
    // MARK: - layer에다 그라디언트 추가하기
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = contentView.bounds
    }
}


