//
//  VisualTagCalendarViewController.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/11.
//

import UIKit

class VisualTagMapViewController: UIViewController{
    
    
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 25/255, green: 0, blue: 80/255, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.text = "원하는 지역을 선택해주세요."
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let btn = UIButton(type: .custom)
        //set title
        btn.setTitle("다음", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 15)
        btn.backgroundColor = UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1)
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
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .black
        btn.configuration = config
        //button image
        btn.setImage(UIImage(systemName: "multiply"), for: .normal)
        //button tag
        btn.tag = 2
        //add action to button
        btn.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var backButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("이전으로 돌아가기", for: .normal)
        btn.setTitleColor(UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 15)
        
        btn.tag = 3
        btn.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //cancel button autolayout
        self.view.addSubview(self.cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.bounds.width/10)/2 - 15),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        //headerTitle autolayout
        view.addSubview(headerTitle)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.bounds.width/10)/2),
            headerTitle.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 7),
            headerTitle.widthAnchor.constraint(equalToConstant: view.bounds.width/10*9)
        ])
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            backButton.widthAnchor.constraint(equalTo: headerTitle.widthAnchor),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //next button autolayout
        self.view.addSubview(self.nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -20),
            nextButton.widthAnchor.constraint(equalToConstant: view.bounds.width/10 * 9),
            nextButton.heightAnchor.constraint(equalToConstant: view.bounds.height/17)
        ])
    }
    
    //handling action for next, cancel button
    @objc func buttonAction(_ sender: Any){
        if let button = sender as? UIButton{
            switch button.tag{
            case 1:
                self.navigationController?.pushViewController(VisualTagPeopleTargetViewController(), animated: true)
            case 2:
                super.dismiss(animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: false)
            case 3:
                self.navigationController?.popViewController(animated: true)
            default:
                print("Error")
            }
        }
    }
}
