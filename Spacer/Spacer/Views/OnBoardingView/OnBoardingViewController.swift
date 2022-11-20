//
//  OnBoardingViewController.swift
//  Spacer
//
//  Created by 허다솔 on 2022/11/21.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    lazy var mainImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var mainLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .mainPurple1
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        view.addSubview(mainImage)
        view.addSubview(mainLabel)
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImage.heightAnchor.constraint(equalToConstant: view.bounds.width * 1.4),
            
            mainLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 32),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 72)
        ])
    }
}
