//
//  VisualTagCalendarViewController.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/11.
//

import UIKit

import FSCalendar

class VisualTagCalendarViewController: UIViewController, FSCalendarDelegateAppearance {
    
    fileprivate weak var calendar: FSCalendar!
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?
    
    
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 25/255, green: 0, blue: 80/255, alpha: 1)
        label.font = .systemFont(for: .header2)
        label.textColor = .mainPurple1
        label.text = "원하는 기간을 선택해주세요"
        return label
    }()
    
    lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .subYellow1
        return view
    }()
    
    lazy var calendarLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .mainPurple6
        label.textColor = .grayscale3
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.font = UIFont(name: "Pretendard-Medium", size: 16)
        return label
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
    
    lazy var myCalendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.today = nil
        //Weekday name 언어 변경
        calendar.locale = NSLocale(localeIdentifier: "ko_KR") as Locale
        calendar.scope = .month  // 월간
        //해당 월에 해당하는 날만 보여주기
        calendar.placeholderType = .none
        calendar.adjustsBoundingRectWhenChangingMonths = true
        //전달 다음달 보여주는 헤더 투명하게 만들기
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        calendar.appearance.headerDateFormat = "YYYY년 MM월"
        calendar.appearance.headerTitleColor = .grayscale1
        calendar.appearance.headerTitleFont = .systemFont(for: .body1)
        calendar.appearance.headerTitleAlignment = .center
        calendar.headerHeight = 45
        calendar.appearance.headerTitleOffset = .init(x: 0, y: -3)
        calendar.appearance.titleFont = .systemFont(for: .body1)
        calendar.appearance.titleDefaultColor = .grayscale1
        calendar.appearance.titleSelectionColor = .grayscale6
        calendar.appearance.weekdayTextColor = .grayscale3
        calendar.register(CustomCalenderCell.self, forCellReuseIdentifier: CustomCalenderCell.identifier)
        return calendar
    }()
    
    lazy var beforeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tag = 1
        button.tintColor = .mainPurple3
        button.addTarget(self, action: #selector(calendarHeaderButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var afterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tag = 2
        button.tintColor = .mainPurple3
        button.addTarget(self, action: #selector(calendarHeaderButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        calendarLabel.attributedText = setCalendarLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        
        //cancel button autolayout
        self.view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalToConstant: 24),
            cancelButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        //next button autolayout
        self.view.addSubview(self.nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        //headerTitle autolayout
        self.view.addSubview(underLineView)
        self.view.addSubview(headerTitle)
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underLineView.leadingAnchor.constraint(equalTo: headerTitle.leadingAnchor, constant: 67),
            underLineView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: -10),
            underLineView.widthAnchor.constraint(equalToConstant: 63),
            underLineView.heightAnchor.constraint(equalToConstant: 13)
        ])
        NSLayoutConstraint.activate([
            headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            headerTitle.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: .padding.startHierarchyPadding),
            headerTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin)
        ])
        
        //calendar label autolayout
        self.view.addSubview(calendarLabel)
        calendarLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            calendarLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            
            calendarLabel.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: .padding.differentHierarchyPadding),
            calendarLabel.heightAnchor.constraint(equalToConstant: view.bounds.height/20)
        ])
        
        //calendar creation && autolayout
        self.view.addSubview(myCalendar)
        self.calendar = myCalendar
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            calendar.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: 16),
            calendar.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        //allow multiple selection to calendar
        calendar.allowsMultipleSelection = true
        
        //before button autolayout
        self.view.addSubview(beforeButton)
        beforeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            beforeButton.centerXAnchor.constraint(equalTo: calendar.calendarHeaderView.centerXAnchor, constant: -70),
            beforeButton.centerYAnchor.constraint(equalTo: calendar.calendarHeaderView.centerYAnchor),
            beforeButton.widthAnchor.constraint(equalToConstant: 16),
            beforeButton.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        //after button autolayout
        self.view.addSubview(afterButton)
        afterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            afterButton.centerXAnchor.constraint(equalTo: calendar.calendarHeaderView.centerXAnchor, constant:  70),
            afterButton.centerYAnchor.constraint(equalTo: calendar.calendarHeaderView.centerYAnchor),
            afterButton.widthAnchor.constraint(equalToConstant: 16),
            afterButton.heightAnchor.constraint(equalToConstant: 16)
        ])
        
    }
}

//button method compilation
extension VisualTagCalendarViewController{
    //handling action for next, cancel button
    @objc func buttonAction(_ sender: Any) {
        if let button = sender as? UIButton {
            switch button.tag {
            case 1:
                self.navigationController?.pushViewController(VisualTagMapViewController(), animated: true)
                if let firstDate = firstDate {
                    UserDefaults.standard.set(shortDateFormatConverter(firstDate), forKey: "firstDate")
                }
                if let lastDate = lastDate {
                    UserDefaults.standard.set(shortDateFormatConverter(lastDate), forKey: "lastDate")
                }
            case 2:
                super.dismiss(animated: true, completion: nil)
                UserDefaults.standard.removeObject(forKey: "firstDate")
                UserDefaults.standard.removeObject(forKey: "lastDate")
            default:
                print("Error")
            }
        }
    }
    
    //handling action for calendar buttons
    @objc func calendarHeaderButton(_ sender: Any) {
        defer {
            beginAppearanceTransition(true, animated: true)
            endAppearanceTransition()
        }
        if let button = sender as? UIButton {
            let _calendar = Calendar.current
            var dateComponents = DateComponents()
            
            switch button.tag {
            case 1:
                dateComponents.month = -1
                calendar.setCurrentPage(_calendar.date(byAdding: dateComponents, to: calendar.currentPage)!, animated: true)
            case 2:
                dateComponents.month = 1
                calendar.setCurrentPage(_calendar.date(byAdding: dateComponents, to: calendar.currentPage)!, animated: true)
            default:
                print("Error")
            }
        }
    }
    
    //set calendar label function using NSMutableAttributedString
    //For inserting text with Image
    private func setCalendarLabel() -> NSMutableAttributedString{
        let attributedString = NSMutableAttributedString(string: " ")
        let calendarImage = NSTextAttachment()
        calendarImage.image = UIImage(systemName: "calendar")?.withTintColor(.mainPurple2, renderingMode: .alwaysOriginal)
        attributedString.append(NSAttributedString("  "))
        attributedString.append(NSAttributedString(attachment: calendarImage))
        attributedString.append(NSAttributedString(" "))
        if firstDate != nil {
            if lastDate != nil {
                attributedString.append(NSAttributedString(string: " \(dateFormatConverter(firstDate!)) - \(dateFormatConverter(lastDate!))"))
            }else{
                attributedString.append(NSAttributedString(string: " \(dateFormatConverter(firstDate!)) - 선택 안함"))
            }
        }else{
            attributedString.append(NSAttributedString(string: " 선택 안함 - 선택 안함"))
        }
        return attributedString
    }
}

//FSCalendar Delegate
extension VisualTagCalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func dateFormatConverter(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = .autoupdatingCurrent
        return dateFormatter.string(from: date)
    }
    
    // 년도를 제외한 기간이 나오도록 date format을 변환해줌
    func shortDateFormatConverter(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: date)
    }
    
    // 토요일 파랑, 일요일 빨강으로 만들기
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        // 오늘 이전의 날짜는 선택하지 못하도록 색상을 회색으로 처리
        if date < Date() {
            return .grayscale5
        }
        
        // 요일을 나타냄, 일:1, 월:2...토:7로 나타내서 -1을 하여 인덱스로 접근 가능하도록 함
        let day = Calendar.current.component(.weekday, from: date) - 1
        
        if Calendar.current.shortWeekdaySymbols[day] == "Sun" || Calendar.current.shortWeekdaySymbols[day] == "일" {
            return .systemRed
        } else if Calendar.current.shortWeekdaySymbols[day] == "Sat" || Calendar.current.shortWeekdaySymbols[day] == "토" {
            return .systemBlue
        } else {
            return .label
        }
    }
    
    func datesRange(from: Date, to: Date) -> [Date]{
        if from > to{
            return [Date]()
        }
        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to{
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
    
    //delegates for calendar
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: CustomCalenderCell.identifier, for: date, at: position)
        return cell
    }
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: monthPosition)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        //return 되기전에 무조건적으로 실행해야하는 코드 viewWillAppear -> AppearanceTransition
        defer{
            configureVisibleCells()
            beginAppearanceTransition(true, animated: true)
            endAppearanceTransition()
        }
        
        // 오늘 이전의 날짜를 선택했을 경우 초기화
        if date < Date(){
            calendar.deselect(date)
            if firstDate != nil{
                calendar.deselect(firstDate!)
            }
            if lastDate != nil{
                calendar.deselect(lastDate!)
            }
            
            if datesRange != nil{
                for d in self.datesRange!{
                    calendar.deselect(d)
                }
            }
            firstDate = nil
            lastDate = nil
            datesRange = []
            
            // 다음 버튼 비활성화
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = .grayscale5
            return
        }
        
        // 처음 선택한 값이 아무것도 없을 경우 선택한 date가 firstDate로 들어감
        if firstDate == nil {
            firstDate =  date
            datesRange = [firstDate!]
            return
        }
        // 처음 선택한 값은 있고 2번째를 선택했을 경우
        if firstDate != nil && lastDate == nil {
            // 만일 2번째 선택한 값이 첫번째 값보다 적다면... 2번째 선택한 값을 firstDate로 바꿔버림
            if date <= firstDate!{
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                return
            }
            // 2번째 선택한 값까지 캘린더에서 선택함
            let range = datesRange(from: firstDate!, to: date)
            lastDate = range.last
            
            for d in range {
                calendar.select(d)
            }
            datesRange = range
            
            // 다음 버튼 활성화
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = .mainPurple3
            return
        }
        
        // 둘 다 값이 있을 경우에 선택했을 경우 다시 초기화
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates{
                calendar.deselect(d)
            }
            lastDate = nil
            firstDate = date
            calendar.select(date)
            datesRange = [firstDate!]
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = .grayscale5
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            lastDate = nil
            firstDate = date
            calendar.select(date)
            datesRange = [firstDate!]
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = .grayscale5
            beginAppearanceTransition(true, animated: true)
            endAppearanceTransition()
            configureVisibleCells()
        } else {
            // 동일한 날짜 선택 가능
            firstDate = date
            lastDate = date
            calendar.select(date)
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = .mainPurple3
            beginAppearanceTransition(true, animated: true)
            endAppearanceTransition()
            configureVisibleCells()
        }
    }
    
    private func configureVisibleCells() {
        var count = 0
        //지금 보는 페이지의 cell 정리
        calendar.visibleCells().forEach{ (cell) in
            count += 1
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date!, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        let customCell = (cell as! CustomCalenderCell)
        var selectionType = SelectionType.none
        if position == .current {
            if calendar.selectedDates.contains(date){
                let previousDate = self.calendar.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.calendar.gregorian.date(byAdding: .day, value: 1, to: date)!
                
                if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
                    // 앞 뒤로 날짜가 선택된 기간에 포함된다면 mid
                    selectionType = .mid
                } else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date) {
                    // 앞 날짜만 선택된 기간에 포함된다면 last
                    selectionType = .last
                } else if calendar.selectedDates.contains(nextDate) {
                    // 뒤 날짜만 선택된 기간에 포함된다면 first
                    selectionType = .first
                } else {
                    selectionType = .single
                }
            } else {
                selectionType = .none
            }
            customCell.selectionType = selectionType
            return
        } else {
            print("not current")
            customCell.selectionType = selectionType
            return
        }
    }
}

