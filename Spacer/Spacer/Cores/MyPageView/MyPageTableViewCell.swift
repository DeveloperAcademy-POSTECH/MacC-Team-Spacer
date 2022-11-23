//
//  MyPageTableViewCell.swift
//  Spacer
//
//  Created by 허다솔 on 2022/11/21.
//

import UIKit

class MyPageTableViewCell: UITableViewCell {
    
    static let identifier = "MyPageTableViewCell"
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(for: .header1)
        label.textColor = .grayscale7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(for: .body3)
        label.textColor = .mainPurple5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    func setLayout() {
        addSubview(mainLabel)
        addSubview(subLabel)
        addSubview(mainImage)
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            subLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 8),
            
            mainImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImage.topAnchor.constraint(equalTo: topAnchor),
            mainImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainImage.widthAnchor.constraint(equalToConstant: 167)
        ])
    }
    
    func configure(mainLabel: String, subLabel: String, mainImage: String, backgroundColor: UIColor) {
        self.mainLabel.text = mainLabel
        self.subLabel.text = subLabel
        self.mainImage.image = UIImage(named: mainImage)
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
