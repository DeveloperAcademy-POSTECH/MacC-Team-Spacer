//
//  VisualTagPeopleTargetView.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/11.
//

import UIKit

class VisualTagPeopleTargetView: UIViewController {

    lazy var nextButton: UIButton = {
        let btn = UIButton(type: .custom)
        //set title
        btn.setTitle("다음", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemPurple
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10.0
        btn.tag = 1
        //add action to button
        btn.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var cancelButton: UIButton = {
        let btn = UIButton(type: .custom)
        //Config of button
        var config = UIButton.Configuration.gray()
        config.title = "X"
        config.baseForegroundColor = .black
        config.image?.withTintColor(.gray)
        //set button configuration
        btn.configuration = config
        //button tag
        btn.tag = 2
        //add action to button
        btn.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var backButton: UIButton = {
        let btn = UIButton(type: .custom)
        //Config of button
        var config = UIButton.Configuration.plain()
        config.title = "이전으로 돌아가기"
        config.baseForegroundColor = .systemPurple
        btn.configuration = config
        btn.tag = 3
        btn.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        

        //next button autolayout
        self.view.addSubview(self.nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            .isActive = true
        nextButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
            .isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 300)
            .isActive = true

        //cancel button autolayout
        self.view.addSubview(self.cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        cancelButton.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 50)
            .isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100)
            .isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 40)
            .isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 40)
            .isActive = true
        
        //backButton button autolayout
        self.view.addSubview(self.backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            .isActive = true
        backButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
            .isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50)
            .isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 300)
            .isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func buttonAction(_ sender: Any){
        if let button = sender as? UIButton{
            switch button.tag{
            case 1:
                self.navigationController?.pushViewController(VisualTagPeopleTargetView(), animated: false)
            case 2:
                super.dismiss(animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: false)
            case 3:
                self.navigationController?.popViewController(animated: false)
            default:
                print("Error")
            }
        }
    }
}
