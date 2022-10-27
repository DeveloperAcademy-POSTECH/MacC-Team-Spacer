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
        button.setImage(UIImage(named: "TagBanner"), for: .normal)
        // TODO: - 우선순위 낮춤(직각으로)
//        button.layer.cornerRadius = 24
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerButton.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
