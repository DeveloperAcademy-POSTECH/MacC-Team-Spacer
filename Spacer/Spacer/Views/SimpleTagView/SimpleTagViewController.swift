//
//  SimpleTagViewController.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/31.
//

import UIKit

import FSCalendar

class SimpleTagViewController: UIViewController {
    
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?
    
    let closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .mainPurple1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let topTitle: UILabel = {
        let label = UILabel()
        label.text = "필터"
        label.textColor = .grayscale1
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "지역"
        label.font = .systemFont(for: .header4)
        label.textColor = .mainPurple1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "지역"
        label.font = .systemFont(for: .header4)
        label.textColor = .mainPurple1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let decorationLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "데코레이션"
        label.font = .systemFont(for: .header4)
        label.textColor = .mainPurple1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let calendarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.backgroundColor = .mainPurple6
        button.setTitleColor(.mainPurple2, for: .normal)
        button.tintColor = .mainPurple1
        button.layer.cornerRadius = 10.0
        button.contentHorizontalAlignment = .leading
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var beforeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tag = 1
        button.tintColor = .mainPurple3
        button.addTarget(self, action: #selector(calendarHeaderButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var afterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tag = 2
        button.tintColor = .mainPurple3
        button.addTarget(self, action: #selector(calendarHeaderButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var myCalendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.backgroundColor = .white
        calendar.today = nil
        calendar.locale = NSLocale(localeIdentifier: "ko_KR") as Locale
        calendar.scope = .month
        
        //해당 월만 보여줄 수 있게끔 하기
        calendar.placeholderType = .none
        calendar.adjustsBoundingRectWhenChangingMonths = true
        
        //전달 다음달 보여주는 헤더 없에버리기
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        
        calendar.appearance.headerDateFormat = "YYYY년 MM월"
        calendar.appearance.headerTitleColor = .grayscale1
        calendar.appearance.headerTitleFont = .systemFont(for: .body1)
        calendar.appearance.headerTitleAlignment = .center
        calendar.headerHeight = 45
        calendar.appearance.headerTitleOffset = .init(x: 0, y: -3)
        calendar.appearance.titleFont = .systemFont(for: .body1)
        calendar.appearance.titleSelectionColor = .grayscale6
        calendar.appearance.weekdayTextColor = .grayscale3
        
        // 모서리 둥글게
        calendar.layer.cornerRadius = 8
        calendar.clipsToBounds = true
        
        // 그림자
        calendar.layer.shadowOffset = CGSize(width: 0, height: 0)
        calendar.layer.shadowColor = UIColor.black.cgColor
        calendar.layer.shadowRadius = 3
        calendar.layer.shadowOpacity = 0.25
        calendar.clipsToBounds = false
        
        calendar.allowsMultipleSelection = true
        
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.register(CustomCalenderCell.self, forCellReuseIdentifier: CustomCalenderCell.identifier)
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    // 캘린더와 확인을 나누는 선
    lazy var calendarDivder: UIView = {
        let UIView = UIView()
        UIView.backgroundColor = .grayscale5
        UIView.tintColor = .red
        UIView.translatesAutoresizingMaskIntoConstraints = false
        return UIView
    }()
    
    // 캘린더 확인 버튼
    lazy var calendarCloseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.grayscale4, for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .subYellow1
        
        setup()
        setAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calendarButton.setAttributedTitle(setCalendarLabel(), for: .normal)
        
    }
    func setup() {
        // nav
        view.addSubview(closeButton)
        view.addSubview(topTitle)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 9),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            topTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        // 날짜
        view.addSubview(dateLabel)
        view.addSubview(calendarButton)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: .padding.startHierarchyPadding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -.padding.margin),
            dateLabel.heightAnchor.constraint(equalToConstant: 24),
            
            calendarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            calendarButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: .padding.underTitlePadding),
            calendarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            calendarButton.heightAnchor.constraint(equalToConstant: 42)
        ])
        
    }
    
    func setAction() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        calendarButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
        calendarCloseButton.addTarget(self, action: #selector(calendarCloseButtonTapped), for: .touchUpInside)
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: false)
    }
    
    @objc func calendarButtonTapped() {
        // 달력
        view.addSubview(myCalendar)
        NSLayoutConstraint.activate([
            myCalendar.topAnchor.constraint(equalTo: calendarButton.bottomAnchor, constant: 20),
            myCalendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            myCalendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            myCalendar.heightAnchor.constraint(equalToConstant: 450)
        ])
        
        // 달력 < 버튼
        view.addSubview(beforeButton)
        NSLayoutConstraint.activate([
            beforeButton.centerXAnchor.constraint(equalTo: myCalendar.calendarHeaderView.centerXAnchor, constant: -70),
            beforeButton.centerYAnchor.constraint(equalTo: myCalendar.calendarHeaderView.centerYAnchor),
            beforeButton.widthAnchor.constraint(equalToConstant: 16),
            beforeButton.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        // 달력 > 버튼
        view.addSubview(afterButton)
        NSLayoutConstraint.activate([
            afterButton.centerXAnchor.constraint(equalTo: myCalendar.calendarHeaderView.centerXAnchor, constant:  70),
            afterButton.centerYAnchor.constraint(equalTo: myCalendar.calendarHeaderView.centerYAnchor),
            afterButton.widthAnchor.constraint(equalToConstant: 16),
            afterButton.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        // 달력 확인 버튼
        myCalendar.addSubview(calendarCloseButton)
        NSLayoutConstraint.activate([
            calendarCloseButton.bottomAnchor.constraint(equalTo: myCalendar.bottomAnchor, constant: -.padding.underTitlePadding),
            calendarCloseButton.trailingAnchor.constraint(equalTo: myCalendar.trailingAnchor, constant: -.padding.underTitlePadding)
        ])
        
        // 달력 divider
        myCalendar.addSubview(calendarDivder)
        NSLayoutConstraint.activate([
            calendarDivder.bottomAnchor.constraint(equalTo: calendarCloseButton.topAnchor, constant: -.padding.underTitlePadding),
            calendarDivder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            calendarDivder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            calendarDivder.heightAnchor.constraint(equalToConstant:1)
        ])
    }
    @objc func calendarCloseButtonTapped() {
        self.myCalendar.removeFromSuperview()
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
                myCalendar.setCurrentPage(_calendar.date(byAdding: dateComponents, to: myCalendar.currentPage)!, animated: true)
            case 2:
                dateComponents.month = 1
                myCalendar.setCurrentPage(_calendar.date(byAdding: dateComponents, to: myCalendar.currentPage)!, animated: true)
            default:
                print("Error")
            }
        }
    }
    
    private func setCalendarLabel() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "  ")
        let calendarImage = NSTextAttachment()
        calendarImage.image = UIImage(systemName: "calendar")?.withTintColor(.mainPurple2)
        attributedString.append(NSAttributedString(attachment: calendarImage))
        if firstDate != nil {
            if lastDate != nil {
                attributedString.append(NSAttributedString(string: " \(dateFormatConverter(firstDate!)) - \(dateFormatConverter(lastDate!))"))
            } else {
                attributedString.append(NSAttributedString(string: " \(dateFormatConverter(firstDate!)) - 선택 안함"))
            }
        } else {
            attributedString.append(NSAttributedString(string: " 선택 안함 - 선택 안함"))
        }
        
        return attributedString
    }
    
}

//FSCalendar Delegate
extension SimpleTagViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func dateFormatConverter(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = .autoupdatingCurrent
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
            return .grayscale1
        }
        
    }
    
    func returnColor (date: Date) -> UIColor? {
        
        let day = Calendar.current.component(.weekday, from: date) - 1
        if Calendar.current.shortWeekdaySymbols[day] == "Sun" || Calendar.current.shortWeekdaySymbols[day] == "일" {
            return .systemRed
        } else if Calendar.current.shortWeekdaySymbols[day] == "Sat" || Calendar.current.shortWeekdaySymbols[day] == "토" {
            return .systemBlue
        } else {
            return .grayscale1
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
        
        // 오늘 이전의 날짜를 선택했을 경우 경고창과 함께 모든 선택 값 초기화
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
            calendarCloseButton.setTitleColor(.mainPurple3, for: .normal)
            calendarCloseButton.isEnabled = true
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
            calendarCloseButton.setTitleColor(.grayscale5, for: .normal)
            calendarCloseButton.isEnabled = false
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
            beginAppearanceTransition(true, animated: true)
            endAppearanceTransition()
            configureVisibleCells()
            calendarCloseButton.setTitleColor(.grayscale5, for: .normal)
            calendarCloseButton.isEnabled = false
        } else {
            // 동일한 날짜 선택 가능
            firstDate = date
            lastDate = date
            calendar.select(date)
            beginAppearanceTransition(true, animated: true)
            endAppearanceTransition()
            configureVisibleCells()
            calendarCloseButton.setTitleColor(.mainPurple3, for: .normal)
            calendarCloseButton.isEnabled = true
        }
    }
    
    private func configureVisibleCells() {
        var count = 0
        //지금 보는 페이지의 cell 정리
        myCalendar.visibleCells().forEach{ (cell) in
            count += 1
            let date = myCalendar.date(for: cell)
            let position = myCalendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date!, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        let customCell = (cell as! CustomCalenderCell)
        var selectionType = SelectionType.none
        if position == .current {
            if myCalendar.selectedDates.contains(date){
                let previousDate = self.myCalendar.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.myCalendar.gregorian.date(byAdding: .day, value: 1, to: date)!
                
                if myCalendar.selectedDates.contains(previousDate) && myCalendar.selectedDates.contains(nextDate) {
                    // 앞 뒤로 날짜가 선택된 기간에 포함된다면 mid
                    selectionType = .mid
                } else if myCalendar.selectedDates.contains(previousDate) && myCalendar.selectedDates.contains(date) {
                    // 앞 날짜만 선택된 기간에 포함된다면 last
                    selectionType = .last
                } else if myCalendar.selectedDates.contains(nextDate) {
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


