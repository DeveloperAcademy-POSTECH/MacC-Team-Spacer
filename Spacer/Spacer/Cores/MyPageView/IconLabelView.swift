//
//  IconLabelView.swift
//  Spacer
//
//  Created by 허다솔 on 2022/11/22.
//

import UIKit

class IconLabelView: UIView {

    lazy var iconImage: UIImageView = {
        let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 14, height: 14))
        icon.tintColor = .mainPurple4
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    lazy var iconLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(for: .caption)
        label.textColor = .grayscale3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(icon: String, label: String) {
        super.init(frame: .zero)
        
        iconImage.image = UIImage(named: icon)?.withRenderingMode(.alwaysOriginal)
        iconLabel.text = label
        
        addSubview(iconImage)
        addSubview(iconLabel)
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImage.topAnchor.constraint(equalTo: topAnchor),
            
            iconLabel.topAnchor.constraint(equalTo: topAnchor),
            iconLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 4)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
