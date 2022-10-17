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
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let selectedUnderline = UIView(frame: frame)
        selectedUnderline.backgroundColor = .black
        selectedUnderline.translatesAutoresizingMaskIntoConstraints = false
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
    
    override init(items: [Any]?) {
        super.init(items: items)
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
        
        let segmentWidth = self.bounds.width / CGFloat(self.numberOfSegments)
        let underlineFinalXPosition = segmentWidth * CGFloat(self.selectedSegmentIndex) +  (segmentWidth / 2) - (selectedUnderline.bounds.width / 2)
        self.selectedUnderline.frame.origin.y = self.bounds.height - 4
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

