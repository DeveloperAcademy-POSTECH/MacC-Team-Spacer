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
    
    // 카페 테이블 수
    private let numberOfTable: UILabel = {
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
    
    
    // 카페 좋아요 수
    private let numberOfFavorites: UILabel = {
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
    
    private lazy var cellURLImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CellLinkURLIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cafeMemoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(for: .body2)
        label.textColor = .grayscale4
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.shadowView.layer.shadowOpacity = 0.15
        self.shadowView.layer.masksToBounds = false
        
        shadowView.addSubview(cafeImageView)
        shadowView.addSubview(cafeName)
        shadowView.addSubview(cafeLocation)
        shadowView.addSubview(cafeLocationImage)
        shadowView.addSubview(numberOfTable)
        shadowView.addSubview(cafeTableImage)
        shadowView.addSubview(numberOfFavorites)
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
        
        let numberOfTableConstraints = [
            numberOfTable.leadingAnchor.constraint(equalTo: cafeTableImage.trailingAnchor, constant: .padding.betweenIconPadding),
            numberOfTable.topAnchor.constraint(equalTo: cafeName.bottomAnchor, constant: .padding.littleBoxTextPadding),
        ]
        
        let cafeTableImageConstraints = [
            cafeTableImage.leadingAnchor.constraint(equalTo: cafeLocation.trailingAnchor, constant: .padding.bigBoxTextPadding),
            cafeTableImage.centerYAnchor.constraint(equalTo: numberOfTable.centerYAnchor),
            cafeTableImage.heightAnchor.constraint(equalToConstant: 18),
            cafeTableImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        let numberOfFavortiesConstraints = [
            numberOfFavorites.leadingAnchor.constraint(equalTo: cafeFavoriteImage.trailingAnchor, constant: .padding.betweenIconPadding),
            numberOfFavorites.topAnchor.constraint(equalTo: cafeLocation.bottomAnchor, constant: .padding.littleBoxTextPadding)
        ]
        
        let cafeFavoriteImageConstraints = [
            cafeFavoriteImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.littleBoxPadding),
            cafeFavoriteImage.centerYAnchor.constraint(equalTo: numberOfFavorites.centerYAnchor),
            cafeFavoriteImage.heightAnchor.constraint(equalToConstant: 18),
            cafeFavoriteImage.widthAnchor.constraint(equalToConstant: 18)
        ]
        
        NSLayoutConstraint.activate(cafeImageViewConstraints)
        NSLayoutConstraint.activate(cafeNameConstraints)
        NSLayoutConstraint.activate(cafeLocationConstraints)
        NSLayoutConstraint.activate(cafeLocationImageConstraints)
        NSLayoutConstraint.activate(numberOfTableConstraints)
        NSLayoutConstraint.activate(cafeTableImageConstraints)
        NSLayoutConstraint.activate(numberOfFavortiesConstraints)
        NSLayoutConstraint.activate(cafeFavoriteImageConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: Cafeinfo, imageURL: String) {
        setVisibilityOfCellComponent()
        setCellThumbnailImage(imageURL: imageURL)
        cellURLImage.removeFromSuperview()
        cafeMemoLabel.removeFromSuperview()
        
        self.cafeName.text = model.cafeName
        self.cafeLocation.text = model.cafeShortAddress
        self.numberOfTable.text = String(model.numberOfTables)
        self.numberOfFavorites.text = String(model.numberOfFavorites)
    }
    
    public func configure(with model: FavoriteURLCafe) {
        // url로 저장한 카페일 경우에 보여주는 셀 세팅
        setVisibilityOfCellComponent(isURLCafe: true)
        setCellThumbnailImage(imageURL: model.cafeImageURL)
        setURLFavoriteCafeCell(memo: model.memo)
        
        self.cafeName.text = model.cafeName
    }
    
    private func setCellThumbnailImage(imageURL: String) {
        // url 주소에서 이미지 불러와 cafeImageView에 적용
        Task {
            let url = URL(string: imageURL)
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            self.cafeImageView.image = UIImage(data: data)
        }
    }
    
    private func setVisibilityOfCellComponent(isURLCafe: Bool = false) {
        // 저장된 카페 종류에 따라 보이는 UI 다르게 설정
        cafeLocationImage.isHidden = isURLCafe
        cafeLocation.isHidden = isURLCafe
        cafeTableImage.isHidden = isURLCafe
        numberOfTable.isHidden = isURLCafe
        cafeFavoriteImage.isHidden = isURLCafe
        numberOfFavorites.isHidden = isURLCafe
    }
    
    private func setURLFavoriteCafeCell(memo: String) {
        // url로 저장한 카페의 셀에 링크 이미지와 카페 메모 추가
        cafeMemoLabel.text = memo
        
        shadowView.addSubview(cellURLImage)
        shadowView.addSubview(cafeMemoLabel)
        
        let cellURLImageConstraints = [
            cellURLImage.widthAnchor.constraint(equalToConstant: 28),
            cellURLImage.heightAnchor.constraint(equalToConstant: 28),
            cellURLImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cellURLImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ]
        
        let cafeMemoLabelConstraints = [
            cafeMemoLabel.topAnchor.constraint(equalTo: cafeName.bottomAnchor, constant: 6),
            cafeMemoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cafeMemoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ]
        
        NSLayoutConstraint.activate(cellURLImageConstraints)
        NSLayoutConstraint.activate(cafeMemoLabelConstraints)
    }
}

