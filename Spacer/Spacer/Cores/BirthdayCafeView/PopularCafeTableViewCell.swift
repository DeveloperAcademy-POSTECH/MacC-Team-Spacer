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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cafeImageView)
        contentView.addSubview(cafeName)
        contentView.addSubview(cafeLocation)
        contentView.addSubview(cafeLocationImage)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let cafeNameConstraints = [
            cafeName.leadingAnchor.constraint(equalTo: cafeImageView.leadingAnchor, constant: .padding.bigBoxPadding),
            cafeName.bottomAnchor.constraint(equalTo: cafeImageView.bottomAnchor, constant: -.padding.bigBoxTextPadding),
        ]
        
        let cafeLocationConstraints = [
            cafeLocation.trailingAnchor.constraint(equalTo: cafeImageView.trailingAnchor, constant: -.padding.bigBoxPadding),
            cafeLocation.bottomAnchor.constraint(equalTo: cafeImageView.bottomAnchor, constant: -.padding.bigBoxPadding),
        ]
        
        let cafeLocationImageConstraints = [
            cafeLocationImage.trailingAnchor.constraint(equalTo: cafeLocation.leadingAnchor, constant: -.padding.betweenIconPadding),
            cafeLocationImage.centerYAnchor.constraint(equalTo: cafeLocation.centerYAnchor),
            cafeLocationImage.heightAnchor.constraint(equalToConstant: 18),
            cafeLocationImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        NSLayoutConstraint.activate(cafeNameConstraints)
        NSLayoutConstraint.activate(cafeLocationConstraints)
        NSLayoutConstraint.activate(cafeLocationImageConstraints)
        
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
        
        // 카페 장소의 앞 2개 단어만 표시
        let longCafeAddress = model.address.components(separatedBy: " ")
        let shortCafeAddress = "\(longCafeAddress[0]) \(longCafeAddress[1])"
        self.cafeLocation.text = shortCafeAddress
        
    }
    
    // MARK: - layer에다 그라디언트 추가하기
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        gradientLayer.frame = contentView.bounds
    }
}


