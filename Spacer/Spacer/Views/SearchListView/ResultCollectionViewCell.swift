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
        label.font = .systemFont(for: .header5)
        label.textColor = .grayscale1
        return label
    }()
    
    let cafeLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body2)
        label.textColor = .grayscale3
        return label
    }()
    
    let cafeLocationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "LocationIcon")
        return imageView
    }()
    
    // 카페 테이블
    private let cafeTable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body1)
        label.textColor = .grayscale3
        return label
    }()
    
    // 카페 테이블 이미지
    private let cafeTableImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "tableIcon")
        return imageView
    }()
    
    
    // 카페 좋아요
    private let cafeFavorite: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body1)
        label.textColor = .grayscale3
        return label
    }()
    
    // 카페 좋아요 이미지
    private let cafeFavoriteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "heartIcon")
        return imageView
    }()
    
    // shadowView
    var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 그림자
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
        shadowView.addSubview(cafeLocation)
        shadowView.addSubview(cafeLocationImage)
        shadowView.addSubview(cafeTable)
        shadowView.addSubview(cafeTableImage)
        shadowView.addSubview(cafeFavorite)
        shadowView.addSubview(cafeFavoriteImage)
        
        let cafeImageViewConstraints = [
            cafeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cafeImageView.topAnchor.constraint(equalTo: topAnchor),
            cafeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cafeImageView.heightAnchor.constraint(equalToConstant: 106),
        ]
        
        let cafeNameConstraints = [
            cafeName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.littleBoxPadding),
            cafeName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding.littleBoxPadding),
            cafeName.topAnchor.constraint(equalTo: cafeImageView.bottomAnchor, constant: .padding.littleBoxPadding),
        ]
        
        let cafeLocationConstraints = [
            cafeLocation.leadingAnchor.constraint(equalTo: cafeLocationImage.trailingAnchor , constant: .padding.betweenIconPadding),
            cafeLocation.topAnchor.constraint(equalTo: cafeName.bottomAnchor, constant: .padding.littleBoxTextPadding),
        ]
        
        let cafeLocationImageConstraints = [
            cafeLocationImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.littleBoxPadding),
            cafeLocationImage.centerYAnchor.constraint(equalTo: cafeLocation.centerYAnchor),
            cafeLocationImage.heightAnchor.constraint(equalToConstant: 18),
            cafeLocationImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        let cafeTableConstraints = [
            cafeTable.leadingAnchor.constraint(equalTo: cafeTableImage.trailingAnchor, constant: .padding.betweenIconPadding),
            cafeTable.topAnchor.constraint(equalTo: cafeName.bottomAnchor, constant: .padding.littleBoxTextPadding),
        ]
        
        let cafeTableImageConstraints = [
            cafeTableImage.leadingAnchor.constraint(equalTo: cafeLocation.trailingAnchor, constant: .padding.bigBoxTextPadding),
            cafeTableImage.centerYAnchor.constraint(equalTo: cafeTable.centerYAnchor),
            cafeTableImage.heightAnchor.constraint(equalToConstant: 18),
            cafeTableImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        let cafeFavoriteConstraints = [
            cafeFavorite.leadingAnchor.constraint(equalTo: cafeFavoriteImage.trailingAnchor, constant: .padding.betweenIconPadding),
            cafeFavorite.topAnchor.constraint(equalTo: cafeLocation.bottomAnchor, constant: .padding.littleBoxTextPadding)
        ]
        
        let cafeFavoriteImageConstraints = [
            cafeFavoriteImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.littleBoxPadding),
            cafeFavoriteImage.centerYAnchor.constraint(equalTo: cafeFavorite.centerYAnchor),
            cafeFavoriteImage.heightAnchor.constraint(equalToConstant: 18),
            cafeFavoriteImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        NSLayoutConstraint.activate(cafeImageViewConstraints)
        NSLayoutConstraint.activate(cafeNameConstraints)
        NSLayoutConstraint.activate(cafeLocationConstraints)
        NSLayoutConstraint.activate(cafeLocationImageConstraints)
        NSLayoutConstraint.activate(cafeTableConstraints)
        NSLayoutConstraint.activate(cafeTableImageConstraints)
        NSLayoutConstraint.activate(cafeFavoriteConstraints)
        NSLayoutConstraint.activate(cafeFavoriteImageConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: CafeInfo) {
        self.cafeName.text = model.name
        self.cafeImageView.image = UIImage(named: model.imageInfos[0].images[0])
        self.cafeLocation.text = model.shortAddress
        self.cafeTable.text = String(model.numberOfTables)
        self.cafeFavorite.text = String(model.numberOfFavorites)
    }
}

