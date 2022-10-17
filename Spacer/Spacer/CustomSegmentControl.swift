//
//  CustomSegmentView.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/17.
//

import UIKit

class CustomSegmentControl: UISegmentedControl {
    
    private lazy var underline: UIView = {
        let underline = UIView()
        underline.backgroundColor = .gray
        underline.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(underline)
        
        return underline
    }()
    
    private lazy var selectedUnderline: UIView = {
        let width = 50.0
        let height = 4.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = CGFloat(self.bounds.size.height - 4)
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        
        let selectedUnderline = UIView(frame: frame)
        selectedUnderline.backgroundColor = .green
//        selectedUnderline.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(selectedUnderline)
        
        return selectedUnderline
    }()
    
    private lazy var fuck: UIView = {
        let fuck = UIView()
        fuck.backgroundColor = .green
        fuck.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fuck)
        
        return fuck
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
        applyContraints()
    }

    init() {
        super.init(frame: CGRect())
        setStyle()
        applyContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyContraints()
        
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
        UIView.animate(
            withDuration: 0.1,
            animations: {
                self.selectedUnderline.frame.origin.x = underlineFinalXPosition
            }
        )
    }
    
    // segmentedControl custom style로 설정
    func setStyle() {
        // underline이 잘리지 않고 보이도록 설정
        self.layer.masksToBounds = false
        
        // tintColor & SegmentTintColor clear
        self.tintColor = .clear
        self.selectedSegmentTintColor = .clear
        
        // segmentedControl background & Divider 투명화: https://ios-development.tistory.com/m/963
        self.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        self.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        
        // 기본 & 선택된 segment의 title 색상 변경
        self.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .normal)
        self.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .selected)
    }
    
    // 제약사항 설정
    func applyContraints() {
        let underlineContraints = [
            underline.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            underline.heightAnchor.constraint(equalToConstant: 2),
            underline.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]


        NSLayoutConstraint.activate(underlineContraints)
    }
    
    
    
}

