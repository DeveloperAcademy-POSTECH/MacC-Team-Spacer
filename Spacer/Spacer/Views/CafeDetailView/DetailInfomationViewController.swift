//
//  DetailInfomationView.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/18.
//

import UIKit

class DetailInfomationViewController: UIViewController {
    // 상세정보 및 카페 조건 등을 보여주는 ViewController
    
    private let eventElementImageNames = ["eventElementCupholder", "eventElementBigBanner", "eventElementCutout", "eventElementVideoOrScreen", "eventElementEntranceBanner", "eventElementDisplayPlace", "evemtElementCustomCookie", "eventElementCustomReceipt"]
    private let eventElementImageLabels = ["컵홀더", "현수막", "등신대", "영상 상영", "배너", "전시 공간", "맞춤 디저트", "맞춤 영수증 "]
    
    // 전화번호 영업시간 등을 보여주는 StackView
    let cafeDetailInfoContainer: UIStackView = {
       let container = UIStackView()
        container.isLayoutMarginsRelativeArrangement = true
        container.directionalLayoutMargins = NSDirectionalEdgeInsets(top: .padding.startHierarchyPadding, leading: .padding.margin, bottom: .padding.startHierarchyPadding, trailing: -.padding.margin)
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
    let eventElementStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: .padding.differentHierarchyPadding, leading: 0, bottom: 0, trailing: 0)
        stackView.axis = .vertical
        stackView.spacing = .padding.underTitlePadding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let eventCostStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: .padding.differentHierarchyPadding, leading: 0, bottom: 0, trailing: 0)
        stackView.axis = .vertical
        stackView.spacing = .padding.underTitlePadding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let cafeAdditionalInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: .padding.differentHierarchyPadding, leading: 0, bottom: 0, trailing: 0)
        stackView.axis = .vertical
        stackView.spacing = .padding.underTitlePadding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // InfomationImageAndText를 적용하기 위한 테스트 코드
        lazy var test = InfomationImageAndText(image: "phone.fill", category: "전화번호", discription: "010-7189-8294")
        test.translatesAutoresizingMaskIntoConstraints = false
        
        lazy var test2 = InfomationImageAndText(image: "mic.fill", category: "SNS", discription: ["twitter": "@hurdasol98", "instagram": "@hurdasol92"])
        test.translatesAutoresizingMaskIntoConstraints = false
        
        lazy var test3 = InfomationImageAndText(image: "clock.fill", category: "운영 시간", discription: "09:00 ~ 21:00")
        test.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cafeDetailInfoContainer)
        view.addSubview(divider)
        view.addSubview(eventElementStackView)
        view.addSubview(eventCostStackView)
        view.addSubview(cafeAdditionalInfoStackView)
        
        setEventElementView(elements: [0, 1])
        setCostView(costs: [1000, 10000, 0])
        setCafeAdditionalInfoView(cafeAdditionalInfo: "문의는 DM으로 부탁드립니다 🙏")
        
        self.cafeDetailInfoContainer.addArrangedSubview(test)
        self.cafeDetailInfoContainer.addArrangedSubview(test2)
        self.cafeDetailInfoContainer.addArrangedSubview(test3)
        
        test.heightAnchor.constraint(equalToConstant: 20).isActive = true
        test2.heightAnchor.constraint(equalToConstant: 42).isActive = true
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
        
        let eventElementStackViewConstraints = [
            eventElementStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            eventElementStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            eventElementStackView.topAnchor.constraint(equalTo: divider.bottomAnchor)
        ]
        
        let eventCostStackViewConstraints = [
            eventCostStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            eventCostStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            eventCostStackView.topAnchor.constraint(equalTo: eventElementStackView.bottomAnchor)
        ]
        
        let cafeAdditionalInfoStackViewConstraints = [
            cafeAdditionalInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            cafeAdditionalInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            cafeAdditionalInfoStackView.topAnchor.constraint(equalTo: eventCostStackView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(cafeDetailInfoContainerConstraints)
        NSLayoutConstraint.activate(dividerConstraints)
        NSLayoutConstraint.activate(eventElementStackViewConstraints)
        NSLayoutConstraint.activate(eventCostStackViewConstraints)
        NSLayoutConstraint.activate(cafeAdditionalInfoStackViewConstraints)
    }
    
    private func makeCafeConditionLabel() -> UILabel {
        let label = UILabel()
        label.text = "카페 조건"
        label.textColor = .mainPurple1
        label.font = .systemFont(for: .header6)
        return label
    }
    
    private func makeConditionTitle(title: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .grayscale3
        titleLabel.font = .systemFont(for: .body3)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        return titleLabel
    }
    
    private func makeEventElements(elements: [Int]) -> UIView {
        let eventElementsLineView = UIView()
        let elementImageHorizontalStackView = UIStackView()
        elementImageHorizontalStackView.axis = .horizontal
        elementImageHorizontalStackView.spacing = .padding.underTitlePadding
        elementImageHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        eventElementsLineView.addSubview(elementImageHorizontalStackView)
        
        for element in elements {
            let elementImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
            elementImage.image = UIImage(named: eventElementImageNames[element])
            elementImage.contentMode = .scaleAspectFit
            elementImage.tag = 100 + element
            
            let elementTitle = UILabel()
            elementTitle.font = .systemFont(for: .caption)
            elementTitle.text = eventElementImageLabels[element]
            elementTitle.textColor = .grayscale1
            elementTitle.translatesAutoresizingMaskIntoConstraints = false
            
            elementImageHorizontalStackView.addArrangedSubview(elementImage)
            eventElementsLineView.addSubview(elementTitle)
            
            let elementTitleConstraints = [
                elementTitle.topAnchor.constraint(equalTo: elementImageHorizontalStackView.bottomAnchor, constant: .padding.betweenButtonsPadding),
                elementTitle.centerXAnchor.constraint(equalTo: elementImage.centerXAnchor)
            ]
            
            NSLayoutConstraint.activate(elementTitleConstraints)
        }
        
        let elementImageHorizontalStackViewConstraints = [
            elementImageHorizontalStackView.topAnchor.constraint(equalTo: eventElementsLineView.topAnchor),
            elementImageHorizontalStackView.centerXAnchor.constraint(equalTo: eventElementsLineView.centerXAnchor),
            elementImageHorizontalStackView.heightAnchor.constraint(equalToConstant: 48)
        ]
        
        NSLayoutConstraint.activate(elementImageHorizontalStackViewConstraints)
        
        return eventElementsLineView
    }
    
    private func setEventElementView(elements: [Int]) {
        let cafeConditionLabel = makeCafeConditionLabel()
        let conditionTitle = makeConditionTitle(title: "이벤트 진행 요소")
        
        eventElementStackView.addArrangedSubview(cafeConditionLabel)
        eventElementStackView.addArrangedSubview(conditionTitle)
        
        if elements.count < 6 {
            let eventElementLineView = makeEventElements(elements: elements)
            eventElementStackView.addArrangedSubview(eventElementLineView)
            
            let eventElementLineViewConstraints = [
                eventElementLineView.leadingAnchor.constraint(equalTo: eventElementStackView.leadingAnchor),
                eventElementLineView.trailingAnchor.constraint(equalTo: eventElementStackView.trailingAnchor),
                eventElementLineView.heightAnchor.constraint(equalToConstant: 80)
            ]
            
            NSLayoutConstraint.activate(eventElementLineViewConstraints)
            
        } else {
            for i in 0...1 {
                let startIndex = i == 0 ? 0 : 4
                let endIndex = i == 0 ? 3 : elements.count - 1
                let eventElementLineView = makeEventElements(elements: Array(elements[startIndex...endIndex]))
                eventElementStackView.addArrangedSubview(eventElementLineView)
                
                let eventElementLineViewConstraints = [
                    eventElementLineView.leadingAnchor.constraint(equalTo: eventElementStackView.leadingAnchor),
                    eventElementLineView.trailingAnchor.constraint(equalTo: eventElementStackView.trailingAnchor),
                    eventElementLineView.heightAnchor.constraint(equalToConstant: 80)
                ]
                
                NSLayoutConstraint.activate(eventElementLineViewConstraints)
            }
        }
        
    }
    
    private func setCostView(costs: [Int]) {
        let costName = ["대관비", "보증금", "예약금"]
        
        let conditionTitle = makeConditionTitle(title: "비용")
        let containerView = UIView()
        containerView.layer.cornerRadius = 16
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 0.1
        containerView.backgroundColor = .mainPurple6
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let costHorizontalStackView = UIStackView()
        costHorizontalStackView.axis = .horizontal
        costHorizontalStackView.spacing = 40
        costHorizontalStackView.alignment = .center
        costHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, cost) in costs.enumerated() {
            let costInfoStackView = UIStackView()
            costInfoStackView.axis = .vertical
            costInfoStackView.alignment = .center
            costInfoStackView.translatesAutoresizingMaskIntoConstraints = false
            
            let costTitle = UILabel()
            costTitle.font = .systemFont(for: .body2)
            costTitle.text = costName[index]
            costTitle.textColor = .grayscale3
            costTitle.translatesAutoresizingMaskIntoConstraints = false
            
            let costLabel = UILabel()
            costLabel.font = .systemFont(for: .body3)
            costLabel.text = "\(cost)원"
            costLabel.textColor = .grayscale1
            costLabel.translatesAutoresizingMaskIntoConstraints = false
            
            costHorizontalStackView.addArrangedSubview(containerView)
            
            costInfoStackView.addArrangedSubview(costTitle)
            costInfoStackView.addArrangedSubview(costLabel)
            
            costHorizontalStackView.addArrangedSubview(costInfoStackView)
        }
        
        
        eventCostStackView.addArrangedSubview(conditionTitle)
        eventCostStackView.addArrangedSubview(containerView)
        
        containerView.addSubview(costHorizontalStackView)
        
        let containerViewConstraints = [
            containerView.leadingAnchor.constraint(equalTo: eventCostStackView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: eventCostStackView.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 107)
        ]
        
        let costHorizontalStackViewConstraints = [
            costHorizontalStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            costHorizontalStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(containerViewConstraints)
        NSLayoutConstraint.activate(costHorizontalStackViewConstraints)
    }
    
    private func setCafeAdditionalInfoView(cafeAdditionalInfo: String) {
        let conditionTitle = makeConditionTitle(title: "기타 사항")
        let additionalInfoLabel = UILabel()
        additionalInfoLabel.font = .systemFont(for: .body3)
        additionalInfoLabel.text = cafeAdditionalInfo
        additionalInfoLabel.textColor = .grayscale1
        additionalInfoLabel.numberOfLines = 0
        
        cafeAdditionalInfoStackView.addArrangedSubview(conditionTitle)
        cafeAdditionalInfoStackView.addArrangedSubview(additionalInfoLabel)
    }
}
