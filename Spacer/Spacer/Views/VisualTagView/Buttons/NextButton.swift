//
//  NextButton.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/20.
//

import UIKit

class NextButton: UIButton {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func setView(title: String?, titleColor: UIColor, backgroundColor: UIColor, target: Any, action: Selector) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 15)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10.0
        self.tag = 1
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}
