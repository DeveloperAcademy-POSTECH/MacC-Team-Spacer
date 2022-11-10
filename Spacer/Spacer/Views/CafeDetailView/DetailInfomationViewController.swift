//
//  DetailInfomationView.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/18.
//

import UIKit

class DetailInfomationViewController: UIViewController {
    // 상세정보 및 카페 조건 등을 보여주는 ViewController
    
    var cafeInfoData: CafeInfo?
    
    // 현재 View의 높이
    var selfHeight: CGFloat = 0
    
    // 카페 이벤트 요소 이미지와 타이틀 이름
    private let eventElementImageNames = ["eventElementCupholder", "eventElementHBanner", "", "eventElementXBanner", "eventElementDisplayPlace", "", "evemtElementCustomCookie", "eventElementCustomReceipt", "eventElementCutout", "", "", "eventElementVideoOrScreen"]
    private let eventElementImageLabels = ["컵홀더", "현수막", "액자", "배너", "전시 공간", "보틀 음료", "맞춤 디저트", "맞춤 영수증", "등신대", "포토 카드", "포토존", "영상 상영"]
    
    // MARK: - UI 요소
    
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
    
    // 카페에서 진행 가능한 이벤트 요소
    lazy var eventElementStackView: UIStackView = UIStackView()
    
    // 보증금 액수
    lazy var eventCostStackView: UIStackView = UIStackView()
    
    // 사장님이 직접 남기는 기타 사항
    lazy var cafeAdditionalInfoStackView: UIStackView = UIStackView()
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 스택뷰 초기 설정
        eventElementStackView = makeStackView()
        eventCostStackView = makeStackView()
        cafeAdditionalInfoStackView = makeStackView()
        
        // 카페 세부 정보 설정
        setCafeDetailInfoContainer()
        
        // 카페 조건 설정
        setEventElementView(elements: cafeInfoData!.eventElement)
        setCostView(costs: cafeInfoData!.cost)
        setCafeAdditionalInfoView(cafeAdditionalInfo: cafeInfoData?.additionalInfo)
        
        view.addSubview(cafeDetailInfoContainer)
        view.addSubview(divider)
        view.addSubview(eventElementStackView)
        view.addSubview(eventCostStackView)
        view.addSubview(cafeAdditionalInfoStackView)
        
        applyConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // 현재 뷰의 총 높이 계산
        selfHeight += cafeDetailInfoContainer.frame.height
        selfHeight += eventElementStackView.frame.height
        selfHeight += eventCostStackView.frame.height
        selfHeight += cafeAdditionalInfoStackView.frame.height
        selfHeight += 8
    }
    
    // MARK: - functions
    
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
    
    // cafeDetailInfoContainer 내부에 들어갈 카테고리별 정보를 세팅
    private func setCafeDetailInfoContainer() {
        lazy var locationCategory = CategoryInfomationLineView(type: CategoryType.location, discription: cafeInfoData?.address)
        locationCategory.translatesAutoresizingMaskIntoConstraints = false
        cafeDetailInfoContainer.addArrangedSubview(locationCategory)
        locationCategory.heightAnchor.constraint(equalToConstant: locationCategory.selfHeight).isActive = true
        
        if let phoneNumber = cafeInfoData?.phoneNumber, phoneNumber != "" {
            // 전화번호 형식에 맞게 수정
            var formatedPhoneNumber = phoneNumber
            formatedPhoneNumber.insert("-", at: formatedPhoneNumber.index(formatedPhoneNumber.startIndex, offsetBy: 3))
            formatedPhoneNumber.insert("-", at: formatedPhoneNumber.index(formatedPhoneNumber.startIndex, offsetBy: 8))
            
            // 전화번호 정보 카테고리에 추가
            lazy var phoneNumberCategory = CategoryInfomationLineView(type: CategoryType.phoneNumber, discription: formatedPhoneNumber)
            phoneNumberCategory.translatesAutoresizingMaskIntoConstraints = false
            cafeDetailInfoContainer.addArrangedSubview(phoneNumberCategory)
            phoneNumberCategory.heightAnchor.constraint(equalToConstant: phoneNumberCategory.selfHeight).isActive = true
        }
        
        // 테이블 수 카테고리 추가
        if let numberOfTables = cafeInfoData?.numberOfTables {
            lazy var tableCategory = CategoryInfomationLineView(type: CategoryType.tables, discription: String(numberOfTables))
            tableCategory.translatesAutoresizingMaskIntoConstraints = false
            cafeDetailInfoContainer.addArrangedSubview(tableCategory)
            tableCategory.heightAnchor.constraint(equalToConstant: tableCategory.selfHeight).isActive = true
        }
        
        // SNS 카테고리 추가
        lazy var SNSCategory = CategoryInfomationLineView(type: CategoryType.SNSList, discription: cafeInfoData!.SNS)
        SNSCategory.translatesAutoresizingMaskIntoConstraints = false
        cafeDetailInfoContainer.addArrangedSubview(SNSCategory)
        SNSCategory.heightAnchor.constraint(equalToConstant: SNSCategory.selfHeight).isActive = true
        
        // weekdayTime, weekendTime 형식에 맞게 수정
        var formatedWeekdayTime: String = ""
        var formatedWeekendTime: String = ""
        if let weekdayTime = cafeInfoData?.weekdayTime, weekdayTime != "" {
            formatedWeekdayTime = weekdayTime
            formatedWeekdayTime.insert(":", at: formatedWeekdayTime.index(formatedWeekdayTime.startIndex, offsetBy: 2))
            formatedWeekdayTime.insert(":", at: formatedWeekdayTime.index(formatedWeekdayTime.startIndex, offsetBy: 8))
        }
        if let weekendTime = cafeInfoData?.weekendTime, weekendTime != "" {
            formatedWeekendTime = weekendTime
            formatedWeekendTime.insert(":", at: formatedWeekendTime.index(formatedWeekendTime.startIndex, offsetBy: 2))
            formatedWeekendTime.insert(":", at: formatedWeekendTime.index(formatedWeekendTime.startIndex, offsetBy: 8))
        }
        
        // 운영 시간 카테고리 추가
        lazy var cafeHoursCategory = CategoryInfomationLineView(type: CategoryType.operationTime, weekdayTime: formatedWeekdayTime, weekendTime: formatedWeekendTime, dayOff: cafeInfoData?.dayOff)
        cafeHoursCategory.translatesAutoresizingMaskIntoConstraints = false
        cafeDetailInfoContainer.addArrangedSubview(cafeHoursCategory)
        cafeHoursCategory.heightAnchor.constraint(equalToConstant: cafeHoursCategory.selfHeight).isActive = true
    }
    
    // 카페 정보를 담을 스택뷰 초기화
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: .padding.differentHierarchyPadding, leading: 0, bottom: 0, trailing: 0)
        stackView.axis = .vertical
        stackView.spacing = .padding.underTitlePadding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    // 카페 상세 조건의 이름을 담은 Label
    private func makeConditionTitle(title: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .grayscale3
        titleLabel.font = .systemFont(for: .body3)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }
    
    // 이벤트 요소를 라인별로 생성
    private func makeEventElements(elements: [Bool], lineNumber: Int) -> UIView {
        // 한 줄에 최대 4개의 이벤트 요소를 담을 View, StackView 생성
        let eventElementsLineView = UIView()
        let elementImageHorizontalStackView = UIStackView()
        elementImageHorizontalStackView.axis = .horizontal
        elementImageHorizontalStackView.spacing = .padding.underTitlePadding
        elementImageHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        eventElementsLineView.addSubview(elementImageHorizontalStackView)
        
        for (i, isIconOn) in elements.enumerated() {
            let index =  4 * lineNumber + i
            
            // TODO: 아이콘 추가 후 삼항연상자 삭제
            // 이벤트 요소를 나타낼 ImageView 생성
            let elementImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
            elementImage.image = UIImage(named: eventElementImageNames[index] == "" ? "eventElementCupholder" : eventElementImageNames[index])
            elementImage.layer.opacity = isIconOn ? 1 : 0.2
            elementImage.contentMode = .scaleAspectFit
            
            // 이벤트 요소에 맞는 이벤트 제목 Label 생성
            let elementTitle = UILabel()
            elementTitle.font = .systemFont(for: .caption)
            elementTitle.text = eventElementImageLabels[index]
            elementTitle.textColor = .grayscale1
            elementTitle.layer.opacity = isIconOn ? 1 : 0.2
            elementTitle.translatesAutoresizingMaskIntoConstraints = false
            
            elementImageHorizontalStackView.addArrangedSubview(elementImage)
            eventElementsLineView.addSubview(elementTitle)
            
            // ImageView와 Label에 제약사항 설정
            let elementTitleConstraints = [
                elementTitle.topAnchor.constraint(equalTo: elementImageHorizontalStackView.bottomAnchor, constant: .padding.betweenButtonsPadding),
                elementTitle.centerXAnchor.constraint(equalTo: elementImage.centerXAnchor)
            ]
            
            NSLayoutConstraint.activate(elementTitleConstraints)
        }
        
        // ImageView를 담는 StackView에 제약사항 설정
        let elementImageHorizontalStackViewConstraints = [
            elementImageHorizontalStackView.topAnchor.constraint(equalTo: eventElementsLineView.topAnchor),
            elementImageHorizontalStackView.centerXAnchor.constraint(equalTo: eventElementsLineView.centerXAnchor),
            elementImageHorizontalStackView.heightAnchor.constraint(equalToConstant: 48)
        ]
        
        NSLayoutConstraint.activate(elementImageHorizontalStackViewConstraints)
        
        return eventElementsLineView
    }
    
    private func setEventElementView(elements: [Bool]) {
        lazy var cafeConditionLabel = UILabel()
        cafeConditionLabel.text = "카페 조건"
        cafeConditionLabel.textColor = .mainPurple1
        cafeConditionLabel.font = .systemFont(for: .header6)

        lazy var conditionTitle = makeConditionTitle(title: "이벤트 진행 요소")
                
        eventElementStackView.addArrangedSubview(cafeConditionLabel)
        eventElementStackView.addArrangedSubview(conditionTitle)
        
        let totalLineCount = Int(ceil(Double(elements.count) / 4.0))
        
        for i in 0..<totalLineCount {
            let starIndex: Int = i * 4
            let endIndex: Int

            if i == totalLineCount - 1 {
                endIndex = elements.count - 1
            } else {
                endIndex = starIndex + 3
            }
            
            let eventElementLineOne = makeEventElements(elements: Array(elements[starIndex...endIndex]), lineNumber: i)
            eventElementStackView.addArrangedSubview(eventElementLineOne)
            
            let eventElementLineOneConstraints = [
                eventElementLineOne.leadingAnchor.constraint(equalTo: eventElementStackView.leadingAnchor),
                eventElementLineOne.trailingAnchor.constraint(equalTo: eventElementStackView.trailingAnchor),
                eventElementLineOne.heightAnchor.constraint(equalToConstant: 80)
            ]
            
            NSLayoutConstraint.activate(eventElementLineOneConstraints)
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
    
    private func setCostView(costs: Int) {
        let costName = "보증금"
        
        lazy var conditionTitle = makeConditionTitle(title: "비용")
        lazy var containerView = UIView()
        containerView.layer.cornerRadius = 16
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 0.1
        containerView.backgroundColor = .mainPurple6
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        lazy var costHorizontalStackView = UIStackView()
        costHorizontalStackView.axis = .horizontal
        costHorizontalStackView.spacing = 40
        costHorizontalStackView.alignment = .center
        costHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        lazy var depositStackView = makeCostTitleAndCost(costName: costName, cost: costs)
        
        costHorizontalStackView.addArrangedSubview(depositStackView)
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
