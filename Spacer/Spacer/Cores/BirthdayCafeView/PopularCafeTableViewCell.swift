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
    private let cafeImageView: UIImageView = {
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
    
    // 카페 위치
    private let cafeLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body1)
        label.textColor = .grayscale5
        return label
    }()
    
    // 카페 위치 이미지
    private let cafeLocationImage: UIImageView = {
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
        label.textColor = .grayscale5
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
        label.textColor = .grayscale5
        return label
    }()
    
    // 카페 좋아요 이미지
    private let cafeFavoriteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "heartIcon")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cafeImageView)
        contentView.addSubview(cafeName)
        contentView.addSubview(cafeLocation)
        contentView.addSubview(cafeLocationImage)
        contentView.addSubview(cafeTable)
        contentView.addSubview(cafeTableImage)
        contentView.addSubview(cafeFavorite)
        contentView.addSubview(cafeFavoriteImage)
        self.cafeTable.text = "1"
        self.cafeFavorite.text = "1"
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let cafeNameConstraints = [
            cafeName.leadingAnchor.constraint(equalTo: cafeImageView.leadingAnchor, constant: .padding.bigBoxPadding),
            cafeName.bottomAnchor.constraint(equalTo: cafeFavoriteImage.topAnchor, constant: -.padding.bigBoxTextPadding),
        ]
        
        let cafeFavoriteConstraints = [
            cafeFavorite.leadingAnchor.constraint(equalTo: cafeFavoriteImage.trailingAnchor, constant: .padding.betweenIconPadding),
            cafeFavorite.bottomAnchor.constraint(equalTo: cafeImageView.bottomAnchor, constant: -.padding.bigBoxPadding),
        ]
        
        let cafeFavoriteImageConstraints = [
            cafeFavoriteImage.leadingAnchor.constraint(equalTo: cafeImageView.leadingAnchor, constant: .padding.bigBoxPadding),
            cafeFavoriteImage.centerYAnchor.constraint(equalTo: cafeFavorite.centerYAnchor),
            cafeFavoriteImage.heightAnchor.constraint(equalToConstant: 18),
            cafeFavoriteImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        let cafeLocationConstraints = [
            cafeLocation.trailingAnchor.constraint(equalTo: cafeTableImage.leadingAnchor, constant: -.padding.bigBoxTextPadding),
            cafeLocation.bottomAnchor.constraint(equalTo: cafeImageView.bottomAnchor, constant: -.padding.bigBoxPadding),
        ]
        
        let cafeLocationImageConstraints = [
            cafeLocationImage.trailingAnchor.constraint(equalTo: cafeLocation.leadingAnchor, constant: -.padding.betweenIconPadding),
            cafeLocationImage.centerYAnchor.constraint(equalTo: cafeLocation.centerYAnchor),
            cafeLocationImage.heightAnchor.constraint(equalToConstant: 18),
            cafeLocationImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        let cafeTableConstraints = [
            cafeTable.trailingAnchor.constraint(equalTo: cafeImageView.trailingAnchor, constant: -.padding.bigBoxPadding),
            cafeTable.bottomAnchor.constraint(equalTo: cafeImageView.bottomAnchor, constant: -.padding.bigBoxPadding),
        ]
        
        let cafeTableImageConstraints = [
            cafeTableImage.trailingAnchor.constraint(equalTo: cafeTable.leadingAnchor, constant: -.padding.betweenIconPadding),
            cafeTableImage.centerYAnchor.constraint(equalTo: cafeTable.centerYAnchor),
            cafeTableImage.heightAnchor.constraint(equalToConstant: 18),
            cafeTableImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        
        
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        // TODO: - 사샤에게 패딩 컨펌받기
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: .padding.betweenContentsPadding/2, left: .padding.homeMargin, bottom: .padding.betweenContentsPadding/2, right: .padding.homeMargin))
        
        NSLayoutConstraint.activate([
            cafeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cafeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cafeImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            cafeImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
        ])
        
        let colorSet = [
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0),
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0),
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4),
            UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)

        ]
        
        let location = [0.0, 0.5, 0.7]
        
        let startEndPoint = (CGPoint(x: 0, y: 0),CGPoint(x: 0, y: 1))
        
        cafeImageView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location,startEndPoints: startEndPoint)
        
    }
    
    // MARK: - 1. cafeInfo를 받아와서 셀에 값을 넣어줌
    
    public func configure(with model: CafeInfo) {
        self.cafeName.text = model.name
        self.cafeImageView.image = UIImage(named: model.imageInfos[0].images[0])
        self.cafeLocation.text = model.shortAddress
        self.cafeTable.text = String(model.numberOfTables)
        self.cafeFavorite.text = String(model.numberOfFavorites)
    }
    
    // MARK: - layer에다 그라디언트 추가하기
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        gradientLayer.frame = contentView.bounds
    }
}


