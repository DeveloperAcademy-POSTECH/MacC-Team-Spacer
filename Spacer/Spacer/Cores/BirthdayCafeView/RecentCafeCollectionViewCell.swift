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
        label.numberOfLines = 2
        return label
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
        label.lineBreakMode = .byTruncatingTail//.byWordWrapping
        label.allowsDefaultTighteningForTruncation = true
        label.numberOfLines = 3
        return label
    }()
    
    // 카페 위치
    private let cafeLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body2)
        label.textColor = .grayscale3
        return label
    }()
    
    // 카페 위치 이미지
    private let cafeLocationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "LocationIcon")
        return imageView
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
        
        // 쉐도우 넣기
        addSubview(shadowView)
        NSLayoutConstraint.activate([
            shadowView.centerXAnchor.constraint(equalTo: centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.topAnchor.constraint(equalTo: topAnchor)
        ])
        self.shadowView.layer.cornerRadius = 12
        self.shadowView.layer.masksToBounds = true
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowView.layer.shadowRadius = 2
        self.shadowView.layer.shadowOpacity = 0.25
        self.shadowView.layer.masksToBounds = false
        
        shadowView.addSubview(cafeImageView)
        shadowView.addSubview(cafeName)
        shadowView.addSubview(cafeReview)
        shadowView.addSubview(cafeLocation)
        shadowView.addSubview(cafeLocationImage)
        
        applyContraints()
    }
    
    func applyContraints() {
        
        let cafeImageViewConstraints = [
            cafeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cafeImageView.topAnchor.constraint(equalTo: topAnchor),
            cafeImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cafeImageView.widthAnchor.constraint(equalToConstant: contentView.bounds.height)
        ]
        
        let cafeNameConstraints = [
            cafeName.lastBaselineAnchor.constraint(equalTo: bottomAnchor, constant: -.padding.littleBoxPadding),
            cafeName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.littleBoxPadding),
            cafeName.trailingAnchor.constraint(equalTo: cafeImageView.trailingAnchor)
        ]
        
        let cafeLocationConstraints = [
            cafeLocation.leadingAnchor.constraint(equalTo: cafeLocationImage.trailingAnchor, constant: .padding.betweenIconPadding),
            cafeLocation.topAnchor.constraint(equalTo: topAnchor, constant: .padding.littleBoxPadding),
            cafeLocation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding.littleBoxPadding)
        ]
        
        let cafeLocationImageConstraints = [
            cafeLocationImage.leadingAnchor.constraint(equalTo: cafeImageView.trailingAnchor, constant: .padding.littleBoxPadding),
            cafeLocationImage.centerYAnchor.constraint(equalTo: cafeLocation.centerYAnchor),
            cafeLocationImage.heightAnchor.constraint(equalToConstant: 18),
            cafeLocationImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        let cafeReviewConstraints = [
            cafeReview.leadingAnchor.constraint(equalTo: cafeImageView.trailingAnchor, constant: .padding.littleBoxPadding),
            cafeReview.topAnchor.constraint(equalTo: cafeLocationImage.bottomAnchor, constant: .padding.bigBoxTextPadding),
            cafeReview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding.littleBoxPadding),
            cafeReview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding.littleBoxPadding)
        ]
        
        NSLayoutConstraint.activate(cafeImageViewConstraints)
        NSLayoutConstraint.activate(cafeNameConstraints)
        NSLayoutConstraint.activate(cafeLocationConstraints)
        NSLayoutConstraint.activate(cafeLocationImageConstraints)
        NSLayoutConstraint.activate(cafeReviewConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = contentView.bounds
        
        let colorSet = [
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0),
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0),
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4),
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        ]
        
        let location = [0.0, 0.3, 0.6]
        
        let startEndPoint = (CGPoint(x: 0, y: 0),CGPoint(x: 0, y: 1))
        
        cafeImageView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location, startEndPoints: startEndPoint)
    }
    
    // MARK: - 1. cafeInfo를 받아와서 셀에 값을 넣어줌
    
    public func configure(with model: CafeInfo) {
        self.cafeName.text = model.name
        self.cafeImageView.image = UIImage(named: model.imageInfos[0].images[0])
        self.cafeLocation.text = model.shortAddress
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
