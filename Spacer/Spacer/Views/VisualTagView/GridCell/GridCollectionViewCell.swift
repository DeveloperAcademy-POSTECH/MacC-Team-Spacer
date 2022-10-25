//
//  GridCollectionViewCell.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/21.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    //cell의 고유한 ID값 지정
    static let identifier = "GridViewCell"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(for: .header6)
        label.textColor = .mainPurple2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        contentView.addSubview(label)
        setConstraints()
    }
    
    //isSelected 변수 override
    override var isSelected: Bool {
        didSet{
            if isSelected{
                self.backgroundColor = UIColor.mainPurple5
                self.layer.borderColor = UIColor.mainPurple2.cgColor
                self.layer.borderWidth = 3
            }else{
                self.backgroundColor = UIColor.mainPurple6
                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.borderWidth = 0
            }
        }
    }
    
    required init(coder aDecoder: NSCoder){
        fatalError("init(coder: ) has not been implemented")
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    public func configue(_ sectionLabel: String){
        self.backgroundColor = UIColor.mainPurple6
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.label.text = sectionLabel
    }
}
