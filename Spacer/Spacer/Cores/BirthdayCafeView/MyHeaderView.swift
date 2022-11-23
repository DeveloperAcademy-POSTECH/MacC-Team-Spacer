//
//  MyHeaderView.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/11.
//

import UIKit

class MyHeaderView: UIView {
    
    static let identifier = "MyHeaderView"
    
    let headerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "TagBanner")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerButton)
        NSLayoutConstraint.activate([
            headerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding.margin),
            headerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding.margin),
            headerButton.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
