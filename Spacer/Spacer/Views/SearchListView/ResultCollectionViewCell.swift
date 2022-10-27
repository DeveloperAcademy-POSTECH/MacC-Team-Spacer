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
    
    let cafeStarRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body2)
        label.textColor = .grayscale3
        return label
    }()
    
    let cafeStarRatingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "StarRatingIcon")
        return imageView
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
    
    var cafePeople: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(for: .body2)
        label.textColor = .grayscale3
        return label
    }()
    
    let cafePeopleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "CafePeopleIcon")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cafeImageView)
        addSubview(cafeName)
        addSubview(cafeStarRating)
        addSubview(cafeStarRatingImage)
        addSubview(cafeLocation)
        addSubview(cafeLocationImage)
        addSubview(cafePeople)
        addSubview(cafePeopleImage)
        
        
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
            cafeName.heightAnchor.constraint(equalToConstant: 21)
        ]
        
        let cafeStarRatingConstraints = [
            cafeStarRating.leadingAnchor.constraint(equalTo: cafeStarRatingImage.trailingAnchor, constant: .padding.betweenIconPadding),
            cafeStarRating.topAnchor.constraint(equalTo: cafeName.bottomAnchor, constant: .padding.littleBoxTextPadding)
        ]
        
        let cafeStarRatingImageConstraints = [
            cafeStarRatingImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.littleBoxPadding),
            cafeStarRatingImage.centerYAnchor.constraint(equalTo: cafeStarRating.centerYAnchor),
            cafeStarRatingImage.heightAnchor.constraint(equalToConstant: 18),
            cafeStarRatingImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        let cafeLocationConstraints = [
            cafeLocation.leadingAnchor.constraint(equalTo: cafeLocationImage.trailingAnchor , constant: .padding.betweenIconPadding),
            cafeLocation.topAnchor.constraint(equalTo: cafeStarRating.bottomAnchor, constant: .padding.littleBoxTextPadding),
        ]
        
        let cafeLocationImageConstraints = [
            cafeLocationImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.littleBoxPadding),
            cafeLocationImage.centerYAnchor.constraint(equalTo: cafeLocation.centerYAnchor),
            cafeLocationImage.heightAnchor.constraint(equalToConstant: 18),
            cafeLocationImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        let cafePeopleConstraints = [
            cafePeople.leadingAnchor.constraint(equalTo: cafePeopleImage.trailingAnchor, constant: .padding.betweenIconPadding),
            cafePeople.topAnchor.constraint(equalTo: cafeLocation.topAnchor),
        ]
        
        let cafePeopleImageConstraints = [
            cafePeopleImage.leadingAnchor.constraint(equalTo: cafeLocation.trailingAnchor, constant: .padding.bigBoxTextPadding),
            cafePeopleImage.centerYAnchor.constraint(equalTo: cafePeople.centerYAnchor),
            cafePeopleImage.heightAnchor.constraint(equalToConstant: 18),
            cafePeopleImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        NSLayoutConstraint.activate(cafeImageViewConstraints)
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
    
    public func configure(with model: CafeInfoModel) {
        self.cafeName.text = model.cafeName
        self.cafeImageView.image = UIImage(named: model.imageDirectories[0])
        self.cafeStarRating.text = String(model.cafeStarRating)
        
        let longCafeAddress = model.cafeAddress.components(separatedBy: " ")
        var shortCafeAddress = "\(longCafeAddress[0]) \(longCafeAddress[1])"
        self.cafeLocation.text = shortCafeAddress
        
        if let cafeMinPeople = model.cafeMinPeople, let cafeMaxPeople = model.cafeMinPeople {
            self.cafePeople.text = "\(cafeMinPeople) ~ \(cafeMaxPeople)"
        } else {
            self.cafePeople.text = "-"
        }
        
    }
}

