//
//  FirstOnBoardViewController.swift
//  Spacer
//
//  Created by 허다솔 on 2022/11/22.
//

import UIKit

class FirstOnBoardViewController: UIViewController {
    
    lazy var backgroundParticle: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "particleImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var mainImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "firstOnBoardImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundParticle)
        view.addSubview(mainImage)
        NSLayoutConstraint.activate([
            backgroundParticle.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundParticle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundParticle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundParticle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin)
        ])
    }
}
