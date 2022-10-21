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
        button.setImage(UIImage(named: "CELEBER"), for: .normal)
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
