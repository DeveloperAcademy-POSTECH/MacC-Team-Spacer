//
//  VisualTagCalendarViewController.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/11.
//

import UIKit

class VisualTagMapViewController: UIViewController {
    
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 25/255, green: 0, blue: 80/255, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.text = "원하는 지역을 선택해주세요."
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = NextButton()
        button.setView(title: "다음", titleColor: .white, backgroundColor: UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1), target: VisualTagMapViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = CancelButton()
        button.setView(foreground: .black, image: UIImage(systemName: "multiply"), target: VisualTagMapViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = BackButton()
        button.setView(title: "이전으로 돌아가기", titleColor: UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1), target: VisualTagMapViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var testButton: UIButton = {
        let button = NextButton()
        button.setView(title: "테스트입니다.", titleColor: .white, backgroundColor: .black, target: VisualTagMapViewController(), action: #selector(test(_:)))
        return button
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
        
        //backButton autolayout
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            backButton.widthAnchor.constraint(equalTo: headerTitle.widthAnchor),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //next button autolayout
        view.addSubview(self.nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -8),
            nextButton.widthAnchor.constraint(equalToConstant: view.bounds.width/10 * 9),
            nextButton.heightAnchor.constraint(equalToConstant: view.bounds.height/17)
        ])
        
        //test button autolayout
        view.addSubview(self.testButton)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testButton.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16),
            testButton.widthAnchor.constraint(equalToConstant: view.bounds.width/10 * 9),
            testButton.heightAnchor.constraint(equalToConstant: view.bounds.height/9.59)
        ])
    }
    
    //handling action for next, cancel button
    @objc func buttonAction(_ sender: Any) {
        if let button = sender as? UIButton {
            switch button.tag {
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
    @objc func test(_ sender: Any){
        if let button = sender as? UIButton {
            switch button.tag {
            case 1:
                print("test")
            default:
                print("Error")
            }
        }
    }
}


