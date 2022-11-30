//
//  SimpleTagCollectionViewCell.swift
//  Spacer
//
//  Created by 허다솔 on 2022/11/15.
//

import UIKit

class SimpleTagCollectionViewCell: UICollectionViewCell {
    static let identifier = "SimpleTagCollectionViewCell"
    
    var buttonTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(for: .body1)
        label.textColor = .mainPurple3
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(buttonTitle)
        setConstraints()
    }
    
    //isSelected 변수 override
    override var isSelected: Bool {
        didSet {
            if isSelected{
                self.backgroundColor = UIColor.mainPurple5
                self.layer.borderColor = UIColor.mainPurple2.cgColor
                self.layer.borderWidth = 2
            } else {
                self.backgroundColor = UIColor.mainPurple6
                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.borderWidth = 0
            }
        }
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            buttonTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    public func configure(buttonTitle: String){
        self.backgroundColor = UIColor.mainPurple6
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.buttonTitle.text = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
