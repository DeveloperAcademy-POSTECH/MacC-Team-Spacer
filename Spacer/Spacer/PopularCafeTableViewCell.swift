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
        imageView.image = UIImage(named: "RANG")
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
        return label
    }()
    
    // 카페 별점
    private let cafeStarRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 92/255, blue: 92/255, alpha: 1)
        return label
    }()
    
    // 카페 위치
    private let cafeLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 카페 인원수
    private let cafePeople: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 즐겨찾기-하트
    private let cafeHeart: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(CafeImageView)
        contentView.addSubview(cafeName)
        contentView.addSubview(cafeStarRating)
        contentView.addSubview(cafeLocation)
        contentView.addSubview(cafePeople)
        contentView.addSubview(cafeHeart)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let cafeNameConstraints = [
            cafeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cafeName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 134),
            cafeName.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let cafeStarRatingConstraints = [
            cafeStarRating.leadingAnchor.constraint(equalTo: cafeName.trailingAnchor, constant: 5),
            cafeStarRating.heightAnchor.constraint(equalToConstant: 20),
            cafeStarRating.topAnchor.constraint(equalTo: cafeName.topAnchor)
        ]
        
        let cafeLocationConstraints = [
            cafeLocation.leadingAnchor.constraint(equalTo: cafeName.leadingAnchor),
            cafeLocation.topAnchor.constraint(equalTo: cafeName.bottomAnchor, constant: 5),
            cafeLocation.heightAnchor.constraint(equalToConstant:20)
        ]
        
        let cafePeopleConstraints = [
            cafePeople.leadingAnchor.constraint(equalTo: cafeLocation.trailingAnchor, constant: 5),
            cafePeople.topAnchor.constraint(equalTo: cafeLocation.topAnchor),
            cafePeople.heightAnchor.constraint(equalToConstant:20)
        ]
        
        let cafeHeartConstarints = [
            cafeHeart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cafeHeart.topAnchor.constraint(equalTo: cafeLocation.topAnchor),
            cafeHeart.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        NSLayoutConstraint.activate(cafeNameConstraints)
        NSLayoutConstraint.activate(cafeStarRatingConstraints)
        NSLayoutConstraint.activate(cafeLocationConstraints)
        NSLayoutConstraint.activate(cafePeopleConstraints)
        NSLayoutConstraint.activate(cafeHeartConstarints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 20, bottom: 7, right: 20))
        
        NSLayoutConstraint.activate([
            CafeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            CafeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            CafeImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            CafeImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
        ])
        
        let colorSet = [
            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1),
            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8),
            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        ]
        
        let location = [0.5,0.7,1.0]
        
        CafeImageView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
        
    }
    
    // MARK: - 1. cafeInfo를 받아와서 셀에 값을 넣어줌
    
    public func configure(with model: CafeInfo) {
        self.cafeName.text = model.cafe_name
        self.CafeImageView.image = UIImage(named: model.image_directories)
        self.cafeStarRating.text = "⭐️" + String(model.cafe_star_rating)
        self.cafeLocation.text = "📍" + String(model.location_id) + "지역"
        self.cafePeople.text = "👤 \(model.cafe_min_people) ~ \(model.cafe_max_people)"
    }
    
    // MARK: - layer에다 그라디언트 추가하기
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = contentView.bounds
    }
}


