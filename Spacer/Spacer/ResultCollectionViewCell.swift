//
//  ResultCollectionViewCell.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/16.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    static let identifier = "ResultCollectionViewCell"
    
    var cafeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    var cafeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let cafeStarRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Pretendard", size: 14)
        return label
    }()
    
    var cafeAddress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var cafePeople: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let cafeHeart: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cafeImageView)
        addSubview(cafeName)
        addSubview(cafeStarRating)
        addSubview(cafeAddress)
        addSubview(cafePeople)
        addSubview(cafeHeart)
        
        let cafeImageViewConstraints = [
            cafeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cafeImageView.topAnchor.constraint(equalTo: topAnchor),
            cafeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cafeImageView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.53 ),
        ]
        
        let cafeNameConstraints = [
            cafeName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cafeName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            cafeName.topAnchor.constraint(equalTo: cafeImageView.bottomAnchor, constant: 10),
            cafeName.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let cafeStarRatingConstraints = [
            cafeStarRating.leadingAnchor.constraint(equalTo: cafeName.leadingAnchor),
            cafeStarRating.topAnchor.constraint(equalTo: cafeName.bottomAnchor, constant: 5),
        ]
        
        let cafeAddressConstraints = [
            cafeAddress.leadingAnchor.constraint(equalTo: cafeStarRating.leadingAnchor),
            cafeAddress.topAnchor.constraint(equalTo: cafeStarRating.bottomAnchor, constant: 5),
        ]
        
        let cafePeopleConstraints = [
            cafePeople.leadingAnchor.constraint(equalTo: cafeAddress.trailingAnchor, constant: 5),
            cafePeople.topAnchor.constraint(equalTo: cafeAddress.topAnchor),
        ]
        
        let cafeHeartConstraints = [
            cafeHeart.leadingAnchor.constraint(equalTo: cafeName.trailingAnchor, constant: 5),
            cafeHeart.topAnchor.constraint(equalTo: cafeName.topAnchor),
        ]
        
        NSLayoutConstraint.activate(cafeImageViewConstraints)
        NSLayoutConstraint.activate(cafeNameConstraints)
        NSLayoutConstraint.activate(cafeStarRatingConstraints)
        NSLayoutConstraint.activate(cafeAddressConstraints)
        NSLayoutConstraint.activate(cafePeopleConstraints)
        NSLayoutConstraint.activate(cafeHeartConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: CafeInfo) {
        self.cafeName.text = model.cafe_name
        self.cafeImageView.image = UIImage(named: model.image_directories)
        self.cafeStarRating.text = "⭐️" + String(model.cafe_star_rating)
        self.cafeAddress.text = "📍" + String(model.address)
        self.cafePeople.text = "👤" + String("\(model.cafe_min_people) ~ \(model.cafe_max_people)")
        
    }
}

