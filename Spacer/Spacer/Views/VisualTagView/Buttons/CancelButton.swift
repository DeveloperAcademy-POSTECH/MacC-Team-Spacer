//
//  CancelButton.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/20.
//

import UIKit

final class CancelButton : UIButton {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func setView(foreground: UIColor, image: UIImage?, target: Any, action: Selector) {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = foreground
        self.configuration = config
        self.setImage(image, for: .normal)
        self.tag = 2
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}
