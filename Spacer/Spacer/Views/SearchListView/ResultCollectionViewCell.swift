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
    
    // shadowView
    var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    
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
        shadowView.addSubview(cafeLocation)
        shadowView.addSubview(cafeLocationImage)
        shadowView.addSubview(cafePeople)
        shadowView.addSubview(cafePeopleImage)
        
        self.shadowView.layer.cornerRadius = 12
        self.shadowView.layer.masksToBounds = true
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowView.layer.shadowRadius = 2
        self.shadowView.layer.shadowOpacity = 0.25
        self.shadowView.layer.masksToBounds = false
        
        
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
        NSLayoutConstraint.activate(cafeLocationConstraints)
        NSLayoutConstraint.activate(cafeLocationImageConstraints)
        NSLayoutConstraint.activate(cafePeopleConstraints)
        NSLayoutConstraint.activate(cafePeopleImageConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: CafeInfo) {
        self.cafeName.text = model.name
        self.cafeImageView.image = UIImage(named: model.imageInfos[0].images[0])
        
        let longCafeAddress = model.address.components(separatedBy: " ")
        let shortCafeAddress = "\(model.shortAddress)"
        self.cafeLocation.text = shortCafeAddress
    }
}

