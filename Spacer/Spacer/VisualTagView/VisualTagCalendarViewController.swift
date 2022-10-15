//
//  VisualTagCalendarViewController.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/11.
//

import UIKit
import FSCalendar


class VisualTagCalendarViewController: UIViewController{
    
    fileprivate weak var calendar: FSCalendar!
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?
    
    lazy var calendarLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textColor = .black
        label.text = firstDate != nil ? String(firstDate.hashValue) : "선택 안함 - 선택 안함"
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let btn = UIButton(type: .custom)
        //set title
        btn.setTitle("다음", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemPurple
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
        config.title = "X"
        config.baseForegroundColor = .black
//        config.image?.withTintColor(.gray)
        //set button configuration
        btn.configuration = config
        //button tag
        btn.tag = 2
        //add action to button
        btn.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        calendarLabel.text = firstDate != nil ? (lastDate != nil ? "\(dateFormatConverter(firstDate!)) - \(dateFormatConverter(lastDate!))" :
                                                    "\(dateFormatConverter(firstDate!)) - 선택 안함") :
                                                    "선택 안함 - 선택 안함"
        
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        
        self.view.addSubview(calendarLabel)
        calendarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendarLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            calendarLabel.widthAnchor.constraint(equalToConstant: 300),
            calendarLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //next button autolayout
        self.view.addSubview(self.nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        //cancel button autolayout
        self.view.addSubview(self.cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            cancelButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.locale = Locale(identifier: "ko_KR")
        view.addSubview(calendar)
        self.calendar = calendar
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            calendar.widthAnchor.constraint(equalToConstant: 300),
            calendar.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        
        calendar.allowsMultipleSelection = true
        
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
}

/*
 해아할 일
 1. extension으로 코드 분리
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
