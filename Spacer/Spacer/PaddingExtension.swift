//
//  PaddingExtension.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/19.
//

import UIKit

// 사용법 stackView.layoutMargins = UIEdgeInsets(top: .padding.differentHierarchyPadding, left: 0, bottom: 0, right: 0)
extension CGFloat {
    static let padding = PaddingTheme()
}

struct PaddingTheme {
    let differentHierarchyPadding = CGFloat(32)
    let startHierarchyPadding = CGFloat(24)
    let underTitlePadding = CGFloat(16)
    let betweenContentsPadding = CGFloat(12)
    let betweenButtonsPadding = CGFloat(8)
}
