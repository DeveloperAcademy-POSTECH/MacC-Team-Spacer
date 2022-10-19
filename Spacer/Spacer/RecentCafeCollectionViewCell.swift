//
//  RecentCafeCollectionViewCell.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/11.
//

import UIKit

class RecentCafeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecentCafeCollectionViewCell"
    
    var cafeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        // 부분만 둥글게 하기
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var cafeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let cafeStarRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 255/255, green: 92/255, blue: 92/255, alpha: 1)
        label.font = UIFont(name: "Pretendard", size: 16)
        return label
    }()
    
    var cafeReview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Pretendard", size: 14)
        label.text = "리뷰의 내용이 들어가야합니다. 긴 내용의 리뷰가 들어갔을 경우 단어에서 잘리도록 설정을 해야합니다."
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.allowsDefaultTighteningForTruncation = true
        label.numberOfLines = 4
        return label
    }()
    
    // 그라디언트
    let gradientLayer = CAGradientLayer()
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = cafeImageView.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cafeImageView)
        addSubview(cafeName)
        addSubview(cafeStarRating)
        addSubview(cafeReview)
        
        let cafeImageViewConstraints = [
            cafeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cafeImageView.topAnchor.constraint(equalTo: topAnchor),
            cafeImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cafeImageView.widthAnchor.constraint(equalToConstant: self.frame.width/2 ),
        ]
        let cafeNameConstraints = [
            cafeName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cafeName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            cafeName.heightAnchor.constraint(equalToConstant: 20)
        ]
        let cafeStarRatingConstraints = [
            cafeStarRating.leadingAnchor.constraint(equalTo: cafeImageView.trailingAnchor, constant: 16),
            cafeStarRating.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
        ]
        let cafeReviewConstraints = [
            cafeReview.leadingAnchor.constraint(equalTo: cafeStarRating.leadingAnchor),
            cafeReview.topAnchor.constraint(equalTo: cafeStarRating.bottomAnchor, constant: 4),
            cafeReview.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10)
        ]
        
        NSLayoutConstraint.activate(cafeImageViewConstraints)
        NSLayoutConstraint.activate(cafeNameConstraints)
        NSLayoutConstraint.activate(cafeStarRatingConstraints)
        NSLayoutConstraint.activate(cafeReviewConstraints)
        
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.green.cgColor
        
        gradientLayer.frame = contentView.bounds
        
        let colorSet = [
            UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.0),
            UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        
        ]
        let location = [0.5,1.0]
        
        cafeImageView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
    }
    
    
    // MARK: - 1. cafeInfo를 받아와서 셀에 값을 넣어줌
    
    public func configure(with model: CafeInfo) {
        self.cafeName.text = model.cafe_name
        self.cafeImageView.image = UIImage(named: model.image_directories)
        self.cafeStarRating.text = String("☆")+String(model.cafe_star_rating)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
