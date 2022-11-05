//
//  SimpleTagViewController.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/31.
//

import UIKit

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
        button.backgroundColor = UIColor(red: 232/255, green: 231/255, blue: 231/255, alpha: 1)
        button.tintColor = .mainPurple1
        button.layer.cornerRadius = 10.0
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
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: false)
    }
    
    private func setCalendarLabel() -> NSMutableAttributedString{
        let attributedString = NSMutableAttributedString(string: " ")
        let calendarImage = NSTextAttachment()
        calendarImage.image = UIImage(systemName: "calendar")
        attributedString.append(NSAttributedString(attachment: calendarImage))
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

    func dateFormatConverter(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }

}
