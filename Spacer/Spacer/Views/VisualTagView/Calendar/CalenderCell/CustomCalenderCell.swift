//
//  CustomCalenderCell.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/17.
//

import UIKit

import FSCalendar

enum SelectionType {
    case none
    case single
    case first
    case last
    case mid
}

class CustomCalenderCell: FSCalendarCell {
    
    static let identifier = "CustomCalenderCell"
    
    weak var circleImageView: UIImageView?
    weak var selectionLayer: CAShapeLayer?
    weak var roundedLayer: CAShapeLayer?
    
    var selectionType: SelectionType = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        // 기간을 채우는 레이어
        let selectionLayer = CAShapeLayer()
        selectionLayer.fillColor = UIColor.mainPurple5.cgColor
        selectionLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel?.layer)
        self.selectionLayer = selectionLayer
        
        // 날짜에 원으로 표시됨
        let roundedLayer = CAShapeLayer()
        roundedLayer.fillColor = UIColor.mainPurple3.cgColor
        roundedLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(roundedLayer, below: self.titleLabel?.layer)
        self.roundedLayer = roundedLayer
        
        // 기존의 레이어 히든처리
        self.shapeLayer.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.selectionLayer?.frame = self.contentView.bounds
        self.roundedLayer?.frame = self.contentView.bounds
        let contentHeight =  self.contentView.frame.height
        let contentWidth = self.contentView.frame.width
        
        let selectionLayerBounds = selectionLayer?.bounds ?? .zero
        let selectionLayerWidth = selectionLayer?.bounds.width ?? .zero
        let roundedLayerHeight = roundedLayer?.frame.height ?? .zero
        let roundedLayerWidth = roundedLayer?.frame.width ?? .zero
        
        switch selectionType {
        case .mid:
            self.selectionLayer?.isHidden = false
            self.roundedLayer?.isHidden = true
            let selectionRect = selectionLayerBounds.insetBy(dx: -1, dy: 4)
                .offsetBy(dx: 0, dy: -4)
            self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath
            
        case .none:
            self.selectionLayer?.isHidden = true
            self.roundedLayer?.isHidden = true
            
        case .first:
            self.selectionLayer?.isHidden = false
            self.roundedLayer?.isHidden = false
            
            let selectionRect = selectionLayerBounds
                .insetBy(dx: selectionLayerWidth / 4, dy: 4)
                .offsetBy(dx: selectionLayerWidth / 4, dy: -4)
            self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath
            
            let diameter: CGFloat = min(roundedLayerHeight, roundedLayerWidth)
            let rect = CGRect(x: (contentWidth - diameter) / 2,
                              y: (contentHeight - diameter) / 2 - 4,
                              width: diameter,
                              height: diameter)
                .insetBy(dx: 2.5, dy: 2.5)
            self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath
            
        case .last:
            self.selectionLayer?.isHidden = false
            self.roundedLayer?.isHidden = false
            
            let selectionRect = selectionLayerBounds
                .insetBy(dx: selectionLayerWidth / 4, dy: 4)
                .offsetBy(dx: -selectionLayerWidth / 4, dy: -4)
            self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath
            
            let diameter: CGFloat = min(roundedLayerHeight, roundedLayerWidth)
            let rect = CGRect(x: (contentWidth - diameter) / 2,
                              y: (contentHeight - diameter) / 2 - 4,
                              width: diameter,
                              height: diameter)
                .insetBy(dx: 2.5, dy: 2.5)
            self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath
            
        case .single:
            self.selectionLayer?.isHidden = true
            self.roundedLayer?.isHidden = false
            
            let diameter: CGFloat = min(roundedLayerHeight, roundedLayerWidth)
            let rect = CGRect(x: (contentWidth - diameter) / 2,
                              y: (contentHeight - diameter) / 2 - 4,
                              width: diameter,
                              height: diameter)
                .insetBy(dx: 2.5, dy: 2.5)
            self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath
        }
    }
}
