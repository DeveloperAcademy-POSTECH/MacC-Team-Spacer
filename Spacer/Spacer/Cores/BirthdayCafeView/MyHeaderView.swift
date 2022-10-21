//
//  MyHeaderView.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/11.
//

import UIKit

class MyHeaderView: UIView {
    
    static let identifier = "MyHeaderView"
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "CELEBER")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
