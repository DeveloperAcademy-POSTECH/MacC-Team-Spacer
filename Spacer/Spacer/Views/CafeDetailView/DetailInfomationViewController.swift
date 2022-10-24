//
//  DetailInfomationView.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/18.
//

import UIKit

class DetailInfomationViewController: UIViewController {
    // 상세정보 및 카페 조건 등을 보여주는 ViewController
    
    // 전화번호 영업시간 등을 보여주는 StackView
    let cafeDetailInfoContainer: UIStackView = {
       let container = UIStackView()
        container.isLayoutMarginsRelativeArrangement = true
        container.directionalLayoutMargins = NSDirectionalEdgeInsets(top: .padding.startHierarchyPadding, leading: 16, bottom: .padding.startHierarchyPadding, trailing: -16)
        container.backgroundColor = .white
        container.axis = .vertical
        container.spacing = .padding.betweenContentsPadding
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .grayscale5
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    // 카페의 이벤트 정보나 조건을 보여주는 StackView
    let cafeConditionContainer: UIStackView = {
        let container = UIStackView()
        container.isLayoutMarginsRelativeArrangement = true
        container.directionalLayoutMargins = NSDirectionalEdgeInsets(top: .padding.differentHierarchyPadding, leading: 16, bottom: 0, trailing: -16)
        container.backgroundColor = .blue
        container.axis = .vertical
        container.spacing = .padding.differentHierarchyPadding
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        // InfomationImageAndText를 적용하기 위한 테스트 코드
        lazy var test = InfomationImageAndText(image: "phone.fill", category: "전화번호", discription: "010-7189-8294")
        test.translatesAutoresizingMaskIntoConstraints = false
        
        lazy var test2 = InfomationImageAndText(image: "mic.fill", category: "SNS", discription: "010-0000-0000")
        test.translatesAutoresizingMaskIntoConstraints = false
        
        lazy var test3 = InfomationImageAndText(image: "clock.fill", category: "운영 시간", discription: "09:00 ~ 21:00")
        test.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cafeDetailInfoContainer)
        view.addSubview(divider)
        view.addSubview(cafeConditionContainer)
        
        self.cafeDetailInfoContainer.addArrangedSubview(test)
        self.cafeDetailInfoContainer.addArrangedSubview(test2)
        self.cafeDetailInfoContainer.addArrangedSubview(test3)
        
        test.heightAnchor.constraint(equalToConstant: 20).isActive = true
        test2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        test3.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let cafeDetailInfoContainerConstraints = [
            cafeDetailInfoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cafeDetailInfoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cafeDetailInfoContainer.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let dividerConstraints = [
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            divider.topAnchor.constraint(equalTo: cafeDetailInfoContainer.bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: 2)
        ]
        
        let cafeConditionContainerConstraints = [
            cafeConditionContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cafeConditionContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cafeConditionContainer.topAnchor.constraint(equalTo: divider.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(cafeDetailInfoContainerConstraints)
        NSLayoutConstraint.activate(dividerConstraints)
        NSLayoutConstraint.activate(cafeConditionContainerConstraints)
    }
}
