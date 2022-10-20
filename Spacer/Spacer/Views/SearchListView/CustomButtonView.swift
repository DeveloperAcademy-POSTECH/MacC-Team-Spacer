//
//  CustomButtonView.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/17.
//

import UIKit

class CustomButtonView: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "arrowtriangle.down.fill")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 11)
        config.imagePlacement = .trailing
        config.imagePadding = 3
        
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.baseBackgroundColor = UIColor(red: 246/255, green: 243/255, blue: 255/255, alpha: 1.0)
        var attrTitle = AttributedString.init("커스텀 버튼")
        attrTitle.foregroundColor = UIColor(red: 79/255, green: 50/255, blue: 194/255, alpha: 1.0)
        config.attributedTitle = attrTitle
        config.baseForegroundColor = .black
        
        self.configuration = config
        self.setTitleColor(.systemRed, for: .normal)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

