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
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 9)
        config.imagePlacement = .trailing
        config.imagePadding = 3
        
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 14.5)
        config.baseBackgroundColor = .mainPurple6
        var attrTitle = AttributedString.init("커스텀 버튼")
        attrTitle.foregroundColor = .mainPurple2
        config.attributedTitle = attrTitle
        config.baseForegroundColor = .grayscale1
        
        self.configuration = config
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

