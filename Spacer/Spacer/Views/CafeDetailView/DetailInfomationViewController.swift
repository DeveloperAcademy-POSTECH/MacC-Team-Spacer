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
    
    // API를 사용해 불러온 카페 기본 정보
    var cafeBasicInfo: Cafeinfo?
    
    // 현재 View의 높이
    var selfHeight: CGFloat = 0
    
    // 카페 이벤트 요소 이미지와 타이틀 이름
    private let eventElementImageNames = ["eventElementCupholder", "eventElementXBanner", "eventElementFrame", "eventElementHBanner", "eventElementExhibitionArea", "eventElementBottle", "eventElementCustomCookie", "eventElementCustomReceipt", "eventElementCutout", "eventElementVideoOrScreen", "eventElementPhotoCard", "eventElementVideoShow"]
    private let eventElementImageLabels = ["컵홀더", "배너", "액자", "현수막", "전시 공간", "보틀 음료", "맞춤 디저트", "맞춤 영수증", "등신대", "영상 상영", "포토 카드", "포토존"]
    
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
    
    private lazy var dividerUnderDetailInfomation: UIView = makeDivider()
    
    private lazy var dividerUnderEventElement: UIView = makeDivider()

    private lazy var dividerUnderCost: UIView = makeDivider()
    
    // 카페에서 진행 가능한 이벤트 요소
    private lazy var eventElementStackView: UIStackView = makeStackView()
    
    // 보증금 액수
    private lazy var eventCostStackView: UIStackView = makeStackView()
    
    // 사장님이 직접 남기는 기타 사항
    private lazy var cafeAdditionalInfoStackView: UIStackView = makeStackView()
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 카페 세부 정보 설정
        setCafeDetailInfoContainer()
        
        // 카페 조건 내부 컴포넌트 설정
        setEventElementView()
        setCostView(cost: cafeBasicInfo?.cafeCost)
        setCafeAdditionalInfoView(cafeAdditionalInfo: cafeBasicInfo?.cafeAdditionalDescription)
        
        view.addSubview(cafeDetailInfoContainer)
        view.addSubview(dividerUnderDetailInfomation)
        view.addSubview(eventElementStackView)
        view.addSubview(dividerUnderEventElement)
        view.addSubview(eventCostStackView)
        view.addSubview(dividerUnderCost)
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
        
        let dividerUnderDetailInfomationConstraints = [
            dividerUnderDetailInfomation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerUnderDetailInfomation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerUnderDetailInfomation.topAnchor.constraint(equalTo: cafeDetailInfoContainer.bottomAnchor),
            dividerUnderDetailInfomation.heightAnchor.constraint(equalToConstant: 2)
        ]
        
        let eventElementStackViewConstraints = [
            eventElementStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            eventElementStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            eventElementStackView.topAnchor.constraint(equalTo: dividerUnderDetailInfomation.bottomAnchor)
        ]
        
        let dividerUnderEventElementConstraints = [
            dividerUnderEventElement.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerUnderEventElement.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerUnderEventElement.topAnchor.constraint(equalTo: eventElementStackView.bottomAnchor, constant: .padding.differentHierarchyPadding),
            dividerUnderEventElement.heightAnchor.constraint(equalToConstant: 2)
        ]
        
        let eventCostStackViewConstraints = [
            eventCostStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            eventCostStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            eventCostStackView.topAnchor.constraint(equalTo: dividerUnderEventElement.bottomAnchor)
        ]
        
        let dividerUnderCostConstraints = [
            dividerUnderCost.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerUnderCost.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerUnderCost.topAnchor.constraint(equalTo: eventCostStackView.bottomAnchor, constant: .padding.differentHierarchyPadding),
            dividerUnderCost.heightAnchor.constraint(equalToConstant: 2)
        ]
        
        let cafeAdditionalInfoStackViewConstraints = [
            cafeAdditionalInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            cafeAdditionalInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            cafeAdditionalInfoStackView.topAnchor.constraint(equalTo: dividerUnderCost.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(cafeDetailInfoContainerConstraints)
        NSLayoutConstraint.activate(dividerUnderDetailInfomationConstraints)
        NSLayoutConstraint.activate(eventElementStackViewConstraints)
        NSLayoutConstraint.activate(dividerUnderEventElementConstraints)
        NSLayoutConstraint.activate(eventCostStackViewConstraints)
        NSLayoutConstraint.activate(dividerUnderCostConstraints)
        NSLayoutConstraint.activate(cafeAdditionalInfoStackViewConstraints)
    }
    
    // cafeDetailInfoContainer 내부에 들어갈 카테고리별 정보를 세팅
    private func setCafeDetailInfoContainer() {
        lazy var locationCategory = CategoryInfomationLineView(type: .location, description: cafeBasicInfo?.cafeAddress)
        locationCategory.translatesAutoresizingMaskIntoConstraints = false
        cafeDetailInfoContainer.addArrangedSubview(locationCategory)
        locationCategory.heightAnchor.constraint(equalToConstant: locationCategory.selfHeight).isActive = true
        
        // 전화번호 정보 카테고리에 추가
        if let phoneNumber = cafeBasicInfo?.cafePhoneNumber {
            lazy var phoneNumberCategory = CategoryInfomationLineView(type: .phoneNumber, description: phoneNumber)
            phoneNumberCategory.translatesAutoresizingMaskIntoConstraints = false
            cafeDetailInfoContainer.addArrangedSubview(phoneNumberCategory)
            phoneNumberCategory.heightAnchor.constraint(equalToConstant: phoneNumberCategory.selfHeight).isActive = true
        }
        
        // 테이블 수 카테고리 추가
        if let numberOfTables = cafeBasicInfo?.numberOfTables {
            lazy var tableCategory = CategoryInfomationLineView(type: .tables, description: String(numberOfTables))
            tableCategory.translatesAutoresizingMaskIntoConstraints = false
            cafeDetailInfoContainer.addArrangedSubview(tableCategory)
            tableCategory.heightAnchor.constraint(equalToConstant: tableCategory.selfHeight).isActive = true
        }
        
        Task {
            // 카페의 sns 정보를 불러오기
            let snsData = try await APICaller.requestGetData(url: "/cafeSNS/\(self.cafeBasicInfo!.cafeID)", dataType: CafeSNSInfo.self) as! CafeSNSInfo
            
            // 카페 sns 정보를 보여줄 view 추가
            lazy var SNSCategory = CategoryInfomationLineView(type: .SNSList, description: snsData)
            SNSCategory.translatesAutoresizingMaskIntoConstraints = false
            self.cafeDetailInfoContainer.addArrangedSubview(SNSCategory)
            SNSCategory.heightAnchor.constraint(equalToConstant: SNSCategory.selfHeight).isActive = true
            
            // 카페의 운영시간 정보 불러오기
            let hoursOfOperate = try await APICaller.requestGetData(url: "/cafeOpenings/\(self.cafeBasicInfo!.cafeID)", dataType: CafeOpenings.self) as! CafeOpenings
            
            // 카페 운영시간 정보를 보여줄 view 추가
            lazy var cafeHoursCategory = CategoryInfomationLineView(type: .operationTime, weekdayTime: hoursOfOperate.cafeWeekdayTime, weekendTime: hoursOfOperate.cafeWeekendTime, dayOff: hoursOfOperate.cafeDayOff)
            cafeHoursCategory.translatesAutoresizingMaskIntoConstraints = false
            self.cafeDetailInfoContainer.addArrangedSubview(cafeHoursCategory)
            cafeHoursCategory.heightAnchor.constraint(equalToConstant: cafeHoursCategory.selfHeight).isActive = true
        }
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
    
    // 세부 정보 요소를 구분할 디바이더 기본 설정
    private func makeDivider() -> UIView {
        let divider = UIView()
        // TODO: Color extentsion 추가 후 수정 필요
        divider.backgroundColor = .grayscale6
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
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
        elementImageHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        eventElementsLineView.addSubview(elementImageHorizontalStackView)
        
        for (i, isIconOn) in elements.enumerated() {
            let index =  4 * lineNumber + i
            
            // 이벤트 요소를 나타낼 ImageView 생성
            let elementImage = UIImageView(frame: .zero)
            elementImage.image = UIImage(named: eventElementImageNames[index])
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
    
    private func setEventElementView() {
        // eventElementStackView의 타이틀 추가
        lazy var conditionTitle = makeConditionTitle(title: "데코레이션 요소")
        eventElementStackView.addArrangedSubview(conditionTitle)
        
        Task {
            // 가능한 이벤트 요소 서버로부터 불러오기
            let elementData = try await APICaller.requestGetData(url: "/cafeFeature/\(self.cafeBasicInfo!.cafeID)", dataType: CafeEventElement.self) as! CafeEventElement
            
            // 받아온 데이터를 Bool Array 형태로 저장
            var elementsInfo: [Bool] = [Bool]()
            elementsInfo.append((elementData.cupHolder != 0))
            elementsInfo.append(elementData.standBanner != 0)
            elementsInfo.append(elementData.photoFrame != 0)
            elementsInfo.append(elementData.banner != 0)
            elementsInfo.append(elementData.displaySpace != 0)
            elementsInfo.append(elementData.bottleDrink != 0)
            elementsInfo.append(elementData.customDesert != 0)
            elementsInfo.append(elementData.customReceipt != 0)
            elementsInfo.append(elementData.cutOut != 0)
            elementsInfo.append(elementData.displayVideo != 0)
            elementsInfo.append(elementData.photoCard != 0)
            elementsInfo.append(elementData.photoZone != 0)
            
            // 이벤트 요소가 추가되는 상황을 가정하여 총 이벤트 개수에 따라 전체 줄 수 계산
            let totalLineCount = Int(ceil(Double(elementsInfo.count) / 4.0))
            
            for i in 0..<totalLineCount {
                let starIndex: Int = i * 4
                let endIndex: Int
                
                if i == totalLineCount - 1 {
                    endIndex = elementsInfo.count - 1
                } else {
                    endIndex = starIndex + 3
                }
                
                let eventElementLine = self.makeEventElements(elements: Array(elementsInfo[starIndex...endIndex]), lineNumber: i)
                self.eventElementStackView.addArrangedSubview(eventElementLine)
                
                let eventElementLineConstraints = [
                    eventElementLine.leadingAnchor.constraint(equalTo: self.eventElementStackView.leadingAnchor),
                    eventElementLine.trailingAnchor.constraint(equalTo: self.eventElementStackView.trailingAnchor),
                    eventElementLine.heightAnchor.constraint(equalToConstant: 80)
                ]
                
                NSLayoutConstraint.activate(eventElementLineConstraints)
            }
        }
    }
    
    private func makeCostTitleAndCost(costName: String, cost: String) -> UIStackView {
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
        
        if cost == "" || cost == " " {
            costLabel.text = "정보가 없습니다"
            costLabel.textColor = .grayscale4
        } else {
            costLabel.text = cost + "원"
            costLabel.textColor = .grayscale1
        }
        
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        
        costInfoStackView.addArrangedSubview(costTitle)
        costInfoStackView.addArrangedSubview(costLabel)
        
        return costInfoStackView
    }
    
    private func setCostView(cost: String?) {
        let costName = "보증금"
        let depositCost: String
        
        if let cost = cost {
            depositCost = cost
        } else {
            depositCost = ""
        }
        
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
        
        lazy var depositStackView = makeCostTitleAndCost(costName: costName, cost: depositCost)
        
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
