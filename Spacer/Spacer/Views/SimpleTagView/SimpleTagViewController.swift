//
//  SimpleTagViewController.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/31.
//

import UIKit

class SimpleTagViewController: UIViewController {

    let closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .mainPurple1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let topTitle: UILabel = {
        let label = UILabel()
        label.text = "필터"
        label.textColor = .grayscale1
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .subYellow1
        
        view.addSubview(closeButton)
        view.addSubview(topTitle)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 9),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            topTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
        ])
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    @objc func closeButtonTapped() {
        dismiss(animated: false)
    }

}
