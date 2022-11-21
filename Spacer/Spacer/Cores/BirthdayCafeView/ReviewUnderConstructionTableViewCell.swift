//
//  ReviewUnderConstructionTableViewCell.swift
//  Spacer
//
//  Created by 허다솔 on 2022/11/17.
//

import UIKit

class ReviewUnderConstructionTableViewCell: UITableViewCell {
    static let identifier = "ReviewUnderConstructionTableViewCell"
    
    private let mainLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "준비 중이에요"
        label.textAlignment = .center
        label.textColor = .mainPurple2
        label.font = .systemFont(for: .header1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .mainPurple6
        addSubview(mainLabel)
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainLabel.widthAnchor.constraint(equalToConstant: bounds.width),
            mainLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: .padding.betweenContentsPadding/2, left: .padding.homeMargin, bottom: .padding.betweenContentsPadding/2, right: .padding.homeMargin))
        contentView.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
