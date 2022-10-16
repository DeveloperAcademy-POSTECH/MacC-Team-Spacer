//
//  VisualTagCalendarViewController.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/11.
//

import UIKit
import FSCalendar


class VisualTagCalendarViewController: UIViewController, FSCalendarDelegateAppearance{
    
    fileprivate weak var calendar: FSCalendar!
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?
    
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 25/255, green: 0, blue: 80/255, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.text = "원하는 날짜를 선택해주세요"
        return label
    }()
    
    lazy var calendarLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.backgroundColor = UIColor(red: 232/255, green: 231/255, blue: 231/255, alpha: 1)
        label.textColor = UIColor(red: 132/255, green: 131/255, blue: 131/255, alpha: 1)
        label.layer.cornerRadius = 10.0
        label.font = UIFont(name: "Pretendard-Medium", size: 15)
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
    
    lazy var myCalendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.today = nil;
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        calendar.appearance.headerDateFormat = "YYYY년 MM월"
        
        
        return calendar
    }()
    
    lazy var beforeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(calendarHeaderButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var afterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tag = 2
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

        //next button autolayout
        self.view.addSubview(self.nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            nextButton.widthAnchor.constraint(equalToConstant: view.bounds.width/10 * 9),
            nextButton.heightAnchor.constraint(equalToConstant: view.bounds.height/17)
        ])
        
        //calendar creation && autolayout
        self.view.addSubview(myCalendar)
        self.calendar = myCalendar
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            calendar.widthAnchor.constraint(equalToConstant: view.bounds.width/10 * 9),
            calendar.heightAnchor.constraint(equalToConstant: view.bounds.width/10 * 9)
        ])
        //allow multiple selection to calendar
        calendar.allowsMultipleSelection = true

        //before button autolayout
        self.view.addSubview(beforeButton)
        beforeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            beforeButton.centerXAnchor.constraint(equalTo: calendar.calendarHeaderView.centerXAnchor, constant: -70),
            beforeButton.centerYAnchor.constraint(equalTo: calendar.calendarHeaderView.centerYAnchor),
            beforeButton.widthAnchor.constraint(equalToConstant: 20),
            beforeButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        //after button autolayout
        self.view.addSubview(afterButton)
        afterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            afterButton.centerXAnchor.constraint(equalTo: calendar.calendarHeaderView.centerXAnchor, constant:  70),
            afterButton.centerYAnchor.constraint(equalTo: calendar.calendarHeaderView.centerYAnchor),
            beforeButton.widthAnchor.constraint(equalToConstant: 20),
            beforeButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        //calendar label autolayout
        self.view.addSubview(calendarLabel)
        calendarLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarLabel.centerXAnchor.constraint(equalTo: calendar.centerXAnchor),
            calendarLabel.bottomAnchor.constraint(equalTo: calendar.topAnchor, constant: -20),
            calendarLabel.widthAnchor.constraint(equalToConstant: view.bounds.width/10 * 9),
            calendarLabel.heightAnchor.constraint(equalToConstant: view.bounds.height/20)
        ])
        
        //cancel button autolayout
        self.view.addSubview(self.cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.leftAnchor.constraint(equalTo: calendarLabel.leftAnchor, constant: -15),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        //headerTitle autolayout
        self.view.addSubview(headerTitle)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerTitle.leadingAnchor.constraint(equalTo: calendarLabel.leadingAnchor),
            headerTitle.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 7),
            headerTitle.widthAnchor.constraint(equalTo: calendarLabel.widthAnchor)
        ])
        
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //handling action for next, cancel button
    @objc func buttonAction(_ sender: Any){
        if let button = sender as? UIButton{
            switch button.tag{
            case 1:
                self.navigationController?.pushViewController(VisualTagMapView(), animated: true)
            case 2:
                super.dismiss(animated: true, completion: nil)
            default:
                print("Error")
            }
        }
    }
    
    //handling action for calendar buttons
    @objc func calendarHeaderButton(_ sender: Any){
        defer{
            viewWillAppear(false)
        }
        if let button = sender as? UIButton{
            let _calendar = Calendar.current
            var dateComponents = DateComponents()
            
            switch button.tag{
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
    private func setCalendarLabel() -> NSMutableAttributedString{
        let attributedString = NSMutableAttributedString(string: " ")
        let calendarImage = NSTextAttachment()
        calendarImage.image = UIImage(systemName: "calendar")
        attributedString.append(NSAttributedString(attachment: calendarImage))
        if firstDate != nil{
            if lastDate != nil{
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

/*
 해아할 일
 2. 선택시 Range Selection으로 선택된 날짜들에 대한 색깔 변경
 3. Hi-Fi대로 날짜 선택된거 수정하기
 */

extension VisualTagCalendarViewController: FSCalendarDelegate, FSCalendarDataSource{
    func dateFormatConverter(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
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
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        //return 되기전에 무조건적으로 실행해야하는 코드
        //viewWIllApear을 통해 뷰가 업데이트 됨
        defer{
            viewWillAppear(false)
        }
        
        if firstDate == nil{
            firstDate =  date
            datesRange = [firstDate!]
            print("dateRange contains: \(datesRange!)")
            return
        }
        
        if firstDate != nil && lastDate == nil{
            if date <= firstDate!{
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                print("datesRange contains: \(datesRange!)")
                return
            }
            
            let range = datesRange(from: firstDate!, to: date)
            lastDate = range.last
            
            for d in range{
                calendar.select(d)
            }
            datesRange = range
            print("datesRange contains: \(datesRange!)")
            return
        }
        
        if firstDate != nil && lastDate != nil{
            for d in calendar.selectedDates{
                calendar.deselect(d)
            }
            lastDate = nil
            firstDate = date
            calendar.select(date)
            datesRange = [firstDate!]
            print("datesRange contains:\(datesRange!)")
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
            viewWillAppear(false)
            print("datesRange contains: \(datesRange!)")
        }
    }
}
