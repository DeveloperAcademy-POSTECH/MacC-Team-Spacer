//
//  RecentCafeCollectionViewCell.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/11.
//

import UIKit

class RecentCafeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecentCafeCollectionViewCell"
    
    // 카페 이미지
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
    
    // 카페명
    var cafeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body3)
        label.textColor = .grayscale6
        return label
    }()
    
    // 카페 별점
    let cafeStarRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body2)
        label.textColor = .grayscale2
        return label
    }()
    
    // 카페 별점 이미지
    private let cafeStarRatingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star")
        return imageView
    }()
    
    // 카페 리뷰
    var cafeReview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body2)
        label.textColor = .grayscale2
        label.text = "리뷰의 내용이 들어가야합니다. 긴 내용의 리뷰가 들어갔을 경우 단어에서 잘리도록 설정을 해야합니다."
        label.textAlignment = .left
        
        // TODO: - lineBreakMode에서 아래 두 옵션을 적용해야함 (단어로 잘리고 뒤에 ... 표시)
        label.lineBreakMode = .byWordWrapping //.byTruncatingTail
        label.allowsDefaultTighteningForTruncation = true
        label.numberOfLines = 3
        return label
    }()
    
    // shadowView
    var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // 그라디언트
    let gradientLayer = CAGradientLayer()
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = cafeImageView.bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(shadowView)
        NSLayoutConstraint.activate([
            shadowView.centerXAnchor.constraint(equalTo: centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.topAnchor.constraint(equalTo: topAnchor)
        ])
        shadowView.addSubview(cafeImageView)
        shadowView.addSubview(cafeName)
        shadowView.addSubview(cafeStarRating)
        shadowView.addSubview(cafeStarRatingImage)
        shadowView.addSubview(cafeReview)
        
        applyContraints()
        
        self.shadowView.layer.cornerRadius = 12
        self.shadowView.layer.masksToBounds = true
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowView.layer.shadowRadius = 2
        self.shadowView.layer.shadowOpacity = 0.25
        self.shadowView.layer.masksToBounds = false
    }
    
    func applyContraints() {
        let cafeImageViewConstraints = [
            cafeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cafeImageView.topAnchor.constraint(equalTo: topAnchor),
            cafeImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cafeImageView.widthAnchor.constraint(equalToConstant: contentView.bounds.height)
        ]
        
        let cafeNameConstraints = [
            cafeName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.littleBoxPadding),
            cafeName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding.littleBoxPadding)
        ]
        
        let cafeStarRatingConstraints = [
            cafeStarRating.leadingAnchor.constraint(equalTo: cafeStarRatingImage.trailingAnchor, constant: .padding.betweenIconPadding),
            cafeStarRating.topAnchor.constraint(equalTo: topAnchor, constant: .padding.littleBoxPadding)
        ]
        
        let cafeStarRatingImageConstraints = [
            cafeStarRatingImage.leadingAnchor.constraint(equalTo: cafeImageView.trailingAnchor, constant: .padding.littleBoxPadding),
            cafeStarRatingImage.topAnchor.constraint(equalTo: topAnchor, constant: .padding.littleBoxPadding)
        ]
        
        let cafeReviewConstraints = [
            cafeReview.leadingAnchor.constraint(equalTo: cafeStarRatingImage.leadingAnchor),
            cafeReview.topAnchor.constraint(equalTo: cafeStarRating.bottomAnchor, constant: .padding.bigBoxTextPadding),
            cafeReview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding.littleBoxPadding),
            cafeReview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding.littleBoxPadding)
        ]
        
        NSLayoutConstraint.activate(cafeImageViewConstraints)
        NSLayoutConstraint.activate(cafeNameConstraints)
        NSLayoutConstraint.activate(cafeStarRatingConstraints)
        NSLayoutConstraint.activate(cafeStarRatingImageConstraints)
        NSLayoutConstraint.activate(cafeReviewConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = contentView.bounds
        
        let colorSet = [
            UIColor(white: 0, alpha: 0),
            UIColor(white: 0, alpha: 0.8),
        ]
        
        let location = [0.5,1.0]
        
        cafeImageView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
    }
    
    // MARK: - 1. cafeInfo를 받아와서 셀에 값을 넣어줌
    
    public func configure(with model: CafeInfo) {
        self.cafeName.text = model.cafe_name
        self.cafeImageView.image = UIImage(named: model.image_directories[0])
        self.cafeStarRating.text = String(model.cafe_star_rating)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
