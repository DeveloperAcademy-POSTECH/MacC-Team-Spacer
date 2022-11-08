//
//  VisualTagCalendarViewController.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/11.
//

import UIKit



class VisualTagMapViewController: UIViewController {
    
    // 서울, 부산 버튼이 선택되었는지 확인
    var isSeoulOn: Bool = false
    var isBusanOn: Bool = false
    
    // 서울,부산 버튼 크기 변경을 위한 Constraint
    var seoulButtonWidth: NSLayoutConstraint?
    var seoulButtonHeight: NSLayoutConstraint?
    var busanButtonWidth: NSLayoutConstraint?
    var busanButtonHeight: NSLayoutConstraint?
    
    // 버튼 백그라운드
    var seoulConfig = UIButton.Configuration.plain()
    var seoulBackConfig = UIBackgroundConfiguration.clear()
    var busanConfig = UIButton.Configuration.plain()
    var busanBackConfig = UIBackgroundConfiguration.clear()
    
    
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = .mainPurple1
        label.font = .systemFont(for: .header2)
        label.text = "원하는 지역을 선택해주세요."
        return label
    }()
    
    let titleUnderLine: UIView = {
        let line = UIView()
        line.backgroundColor = .subYellow1
        return line
    }()
    
    lazy var nextButton: UIButton = {
        let button = NextButton()
        button.setView(title: "다음", titleColor: .grayscale6, backgroundColor: .grayscale5, target: VisualTagCalendarViewController(), action: #selector(buttonAction(_:)))
        button.isEnabled = false
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = CancelButton()
        button.setView(foreground: .mainPurple1, image: UIImage(systemName: "multiply"), target: VisualTagCalendarViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = BackButton()
        button.setView(title: "이전으로 돌아가기", titleColor: .grayscale3, target: VisualTagMapViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var mapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "map")
        return imageView
    }()
    
    lazy var seoulButton: UIButton = {
        seoulBackConfig.image = UIImage(named: "mapButtonUnselected")
        seoulConfig.background = seoulBackConfig
        var seoulAttr = AttributedString.init("서울")
        seoulAttr.font = .systemFont(for: .header6)
        seoulConfig.attributedTitle = seoulAttr
        seoulConfig.baseForegroundColor = .mainPurple2
        seoulConfig.contentInsets = .init(top: -4, leading: 0, bottom: 0, trailing: 0)
        let button = UIButton(configuration: seoulConfig)
        return button
    }()
    
    lazy var busanButton: UIButton = {
        busanBackConfig.image = UIImage(named: "mapButtonUnselected")
        busanConfig.background = busanBackConfig
        var busanAttr = AttributedString.init("부산")
        busanAttr.font = .systemFont(for: .header6)
        busanConfig.attributedTitle = busanAttr
        busanConfig.baseForegroundColor = .mainPurple2
        busanConfig.contentInsets = .init(top: -4, leading: 0, bottom: 0, trailing: 0)
        let button = UIButton(configuration: busanConfig)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        applyConstraints()
        buttonSetup()
    }

    func applyConstraints() {
        //cancel button autolayout
        self.view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalToConstant: 24),
            cancelButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        //headerTitle autolayout
        view.addSubview(titleUnderLine)
        view.addSubview(headerTitle)
        titleUnderLine.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleUnderLine.leadingAnchor.constraint(equalTo: headerTitle.leadingAnchor, constant: 66),
            titleUnderLine.topAnchor.constraint(equalTo: headerTitle.topAnchor, constant: 18),
            titleUnderLine.widthAnchor.constraint(equalToConstant: 64),
            titleUnderLine.heightAnchor.constraint(equalToConstant: 13)
        ])
        NSLayoutConstraint.activate([
            headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            headerTitle.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: .padding.startHierarchyPadding)
        ])
        
        //backButton autolayout
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -.padding.underTitlePadding),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //next button autolayout
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -.padding.underTitlePadding),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            nextButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        // 지도
        view.addSubview(mapImageView)
        mapImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapImageView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 60),
            mapImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapImageView.heightAnchor.constraint(equalToConstant: 430),
            mapImageView.widthAnchor.constraint(equalToConstant: 290)
        ])
        
        // 서울 버튼
        view.addSubview(seoulButton)
        seoulButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seoulButton.centerXAnchor.constraint(equalTo: mapImageView.leadingAnchor, constant: 97),
            seoulButton.centerYAnchor.constraint(equalTo: mapImageView.topAnchor, constant: 48)
        ])
        // 변경되는 constraint를 위해서 따로 설정
        seoulButtonWidth = seoulButton.widthAnchor.constraint(equalToConstant: 100)
        seoulButtonWidth?.isActive = true
        seoulButtonHeight = seoulButton.heightAnchor.constraint(equalToConstant: 110)
        seoulButtonHeight?.isActive = true
        
        // 부산 버튼
        view.addSubview(busanButton)
        busanButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            busanButton.centerXAnchor.constraint(equalTo: mapImageView.trailingAnchor, constant: -61),
            busanButton.centerYAnchor.constraint(equalTo: mapImageView.bottomAnchor, constant: -215)
            
        ])
        busanButtonWidth = busanButton.widthAnchor.constraint(equalToConstant: 100)
        busanButtonWidth?.isActive = true
        busanButtonHeight = busanButton.heightAnchor.constraint(equalToConstant: 110)
        busanButtonHeight?.isActive = true
    }
    
    func buttonSetup() {
        seoulButton.addTarget(self, action: #selector(seoulButtonTapped), for: .touchUpInside)
        busanButton.addTarget(self, action: #selector(busanButtonTapped), for: .touchUpInside)
    }
    
    @objc func seoulButtonTapped() {
        isBusanOn = false
        isSeoulOn.toggle()
        if isSeoulOn {
            // 버튼 크기 변경
            seoulButtonWidth?.constant = 130
            seoulButtonHeight?.constant = 140
            busanButtonWidth?.constant = 100
            busanButtonHeight?.constant = 110
            
            // 서울 버튼 선택된 이미지로 변경
            seoulBackConfig.image = UIImage(named: "mapButtonSelected")
            // 부산 버튼 선택안된 이미지로 변경
            busanBackConfig.image = UIImage(named: "mapButtonUnselected")
            
            // 다음 버튼 활성화
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = .mainPurple3
        } else {
            // 버튼 크기 변경
            seoulButtonWidth?.constant = 100
            seoulButtonHeight?.constant = 110
            // 서울 버튼 선택안된 이미지로 변경
            seoulBackConfig.image = UIImage(named: "mapButtonUnselected")
            
            // 다음 버튼 비활성화
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = .grayscale5
        }
        
        seoulConfig.background = seoulBackConfig
        seoulButton.configuration = seoulConfig
        busanConfig.background = busanBackConfig
        busanButton.configuration = busanConfig
    }
    
    @objc func busanButtonTapped() {
        isSeoulOn = false
        isBusanOn.toggle()
        if isBusanOn {
            // 버튼 크기 변경
            busanButtonWidth?.constant = 130
            busanButtonHeight?.constant = 140
            seoulButtonWidth?.constant = 100
            seoulButtonHeight?.constant = 110
            
            // 부산 버튼 선택된 이미지로 변경
            busanBackConfig.image = UIImage(named: "mapButtonSelected")
            // 서울 버튼 선택안된 이미지로 변경
            seoulBackConfig.image = UIImage(named: "mapButtonUnselected")
            
            // 다음 버튼 활성화
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = .mainPurple3
        } else {
            // 버튼 크기 변경
            busanButtonWidth?.constant = 100
            busanButtonHeight?.constant = 110
            // 부산 버튼 선택안된 이미지로 변경
            busanBackConfig.image = UIImage(named: "mapButtonUnselected")
            
            // 다음 버튼 비활성화
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = .grayscale5
        }
        
        seoulConfig.background = seoulBackConfig
        seoulButton.configuration = seoulConfig
        busanConfig.background = busanBackConfig
        busanButton.configuration = busanConfig
    }
    
    
    //handling action for next, cancel button
    @objc func buttonAction(_ sender: Any) {
        if let button = sender as? UIButton {
            switch button.tag {
            case 1:
                self.navigationController?.pushViewController(VisualTagCategoryViewController(), animated: true)
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
