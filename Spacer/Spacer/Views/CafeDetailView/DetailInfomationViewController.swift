//
//  DetailInfomationView.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/18.
//

import UIKit

class DetailInfomationViewController: UIViewController {
    // 상세정보 및 카페 조건 등을 보여주는 ViewController
    
    var cafeInfoData: CafeInfoModel?
    
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
    lazy var eventElementStackView: UIStackView = UIStackView()
    
    lazy var eventCostStackView: UIStackView = UIStackView()
    
    lazy var cafeAdditionalInfoStackView: UIStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventElementStackView = makeStackView()
        eventCostStackView = makeStackView()
        cafeAdditionalInfoStackView = makeStackView()
        
        lazy var phoneNumber = InfomationImageAndText(image: "callIcon", category: "전화번호", discription: cafeInfoData?.cafePhoneNumber)
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        
        lazy var SNSInfo = InfomationImageAndText(image: "messageIcon", category: "SNS", discription: cafeInfoData!.SNS)
        SNSInfo.translatesAutoresizingMaskIntoConstraints = false
        
        lazy var cafeHours = InfomationImageAndText(image: "timeIcon", category: "운영 시간", discription: "09:00 ~ 21:00")
        cafeHours.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cafeDetailInfoContainer)
        view.addSubview(divider)
        view.addSubview(eventElementStackView)
        view.addSubview(eventCostStackView)
        view.addSubview(cafeAdditionalInfoStackView)
        
        setEventElementView(elements: cafeInfoData?.cafeEventElement ?? [])
        setCostView(costs: cafeInfoData!.cafeCosts)
        setCafeAdditionalInfoView(cafeAdditionalInfo: cafeInfoData?.cafeAdditionalInfo)
        
        self.cafeDetailInfoContainer.addArrangedSubview(phoneNumber)
        self.cafeDetailInfoContainer.addArrangedSubview(SNSInfo)
        self.cafeDetailInfoContainer.addArrangedSubview(cafeHours)
        
        phoneNumber.heightAnchor.constraint(equalToConstant: 20).isActive = true
        SNSInfo.heightAnchor.constraint(equalToConstant: SNSInfo.selfHeight).isActive = true
        cafeHours.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
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
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: .padding.differentHierarchyPadding, leading: 0, bottom: 0, trailing: 0)
        stackView.axis = .vertical
        stackView.spacing = .padding.underTitlePadding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    private func makeEventElements(elements: [Int]?) -> UIView {
        let eventElementsLineView = UIView()
        let elementImageHorizontalStackView = UIStackView()
        elementImageHorizontalStackView.axis = .horizontal
        elementImageHorizontalStackView.spacing = .padding.underTitlePadding
        elementImageHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        eventElementsLineView.addSubview(elementImageHorizontalStackView)
        
        for element in elements! {
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
    
    private func setEventElementView(elements: [Int]?) {
        let cafeConditionLabel = makeCafeConditionLabel()
        let conditionTitle = makeConditionTitle(title: "이벤트 진행 요소")
        
        eventElementStackView.addArrangedSubview(cafeConditionLabel)
        eventElementStackView.addArrangedSubview(conditionTitle)
        
        if elements!.count < 6 {
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
                let endIndex = i == 0 ? 3 : elements!.count - 1
                let eventElementLineView = makeEventElements(elements: Array(elements![startIndex...endIndex]))
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
    
    private func makeCostTitleAndCost(costName: String, cost: Int) -> UIStackView {
        let costInfoStackView = UIStackView()
        costInfoStackView.axis = .vertical
        costInfoStackView.alignment = .center
        costInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let costTitle = UILabel()
        costTitle.font = .systemFont(for: .body2)
        costTitle.text = costName
        costTitle.textColor = .grayscale3
        costTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let costLabel = UILabel()
        costLabel.font = .systemFont(for: .body3)
        costLabel.text = "\(cost)원"
        costLabel.textColor = .grayscale1
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        
        costInfoStackView.addArrangedSubview(costTitle)
        costInfoStackView.addArrangedSubview(costLabel)
        
        return costInfoStackView
    }
    
    private func setCostView(costs: CostsList) {
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
        
        let rentalStackView = makeCostTitleAndCost(costName: "대관비", cost: costs.rentalFee ?? 0)
        let depositStackView = makeCostTitleAndCost(costName: "보증금", cost: costs.deposit ?? 0)
        let reservationStackView = makeCostTitleAndCost(costName: "예약금", cost: costs.reservartion ?? 0)
        
        costHorizontalStackView.addArrangedSubview(rentalStackView)
        costHorizontalStackView.addArrangedSubview(depositStackView)
        costHorizontalStackView.addArrangedSubview(reservationStackView)

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
    
    private func setCafeAdditionalInfoView(cafeAdditionalInfo: String?) {
        let conditionTitle = makeConditionTitle(title: "기타 사항")
        
        cafeAdditionalInfoStackView.addArrangedSubview(conditionTitle)
        
        if let additionalInfoText = cafeAdditionalInfo {
            let additionalInfoLabel = UILabel()
            additionalInfoLabel.font = .systemFont(for: .body3)
            additionalInfoLabel.text = additionalInfoText
            additionalInfoLabel.textColor = .grayscale1
            additionalInfoLabel.numberOfLines = 0
            
            cafeAdditionalInfoStackView.addArrangedSubview(additionalInfoLabel)
        }
    }
}
