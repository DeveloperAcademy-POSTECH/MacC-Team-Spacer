//
//  OnBoardingViewController.swift
//  Spacer
//
//  Created by 허다솔 on 2022/11/21.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    lazy var backgroundView: UIView = {
        let UIView = UIView()
        UIView.translatesAutoresizingMaskIntoConstraints = false
        return UIView
    }()
    
    lazy var mainImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var mainLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .mainPurple1
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        view.addSubview(backgroundView)
        view.addSubview(mainImage)
        view.addSubview(mainLabel)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: mainLabel.topAnchor , constant: -32),
            
            mainImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 46),
            mainImage.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -160),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 72)
        ])
    }
}
