//
//  GridCollectionViewCell.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/21.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    //cell의 고유한 ID값 지정
    static let identifier = "GridViewCell"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(for: .header6)
        label.textColor = .mainPurple2
        label.numberOfLines = 2
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var checkMark: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.mainPurple2, renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        setConstraints()
    }
    
    //isSelected 변수 override
    override var isSelected: Bool {
        didSet{
            if isSelected{
                self.backgroundColor = UIColor.mainPurple5
                self.layer.borderColor = UIColor.mainPurple2.cgColor
                self.layer.borderWidth = 3
                contentView.addSubview(checkMark)
                NSLayoutConstraint.activate([
                    checkMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                    checkMark.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 12),
                    checkMark.widthAnchor.constraint(equalToConstant: 17),
                    checkMark.heightAnchor.constraint(equalToConstant: 17)
                ])
            }else{
                self.backgroundColor = UIColor.mainPurple6
                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.borderWidth = 0
                checkMark.removeFromSuperview()
            }
        }
    }
    
    required init(coder aDecoder: NSCoder){
        fatalError("init(coder: ) has not been implemented")
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.firstBaselineAnchor.constraint(equalTo: contentView.topAnchor),
            
            label.lastBaselineAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            label.widthAnchor.constraint(equalToConstant: 70),

        ])
        
    }
   
    public func configure(_ sectionLabel: String, _ imageName: String){
        self.backgroundColor = UIColor.mainPurple6
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.label.text = sectionLabel
        
        self.imageView.image = UIImage(named: imageName)
    }
}
