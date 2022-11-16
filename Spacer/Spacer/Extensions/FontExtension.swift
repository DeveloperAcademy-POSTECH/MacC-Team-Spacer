//
//  FontExtension.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/19.
//

import UIKit

// 사용법 label.font = .systemFont(for: .header1)
extension UIFont {
    static func systemFont(for customStyle: CustomTextStyle) -> UIFont {
        var customFont: UIFont!
        
        switch customStyle {
        case .header1:
            customFont = UIFont(name: CustomFont.esamanruBold.name, size: 24)!
        case .header1_2:
            customFont = UIFont(name: CustomFont.esamanruBold.name, size: 20)!
        case .header2:
            customFont = UIFont(name: CustomFont.pretendardSemiBold.name, size: 24)!
        case .header3:
            customFont = UIFont(name: CustomFont.pretendardBold.name, size: 20)!
        case .header4:
            customFont = UIFont(name: CustomFont.pretendardSemiBold.name, size: 20)!
        case .header5:
            customFont = UIFont(name: CustomFont.pretendardSemiBold.name, size: 18)!
        case .header6:
            customFont = UIFont(name: CustomFont.pretendardSemiBold.name, size: 16)!
        case .body1:
            customFont = UIFont(name: CustomFont.pretendardMedium.name, size: 16)!
        case .body2:
            customFont = UIFont(name: CustomFont.pretendardMedium.name, size: 14)!
        case .body3:
            customFont = UIFont(name: CustomFont.pretendardRegular.name, size: 14)!
        case .caption:
            customFont = UIFont(name: CustomFont.pretendardRegular.name, size: 12)!
        }
        
        return customFont
    }
}

enum CustomFont {
    case esamanruBold
    case pretendardSemiBold
    case pretendardBold
    case pretendardMedium
    case pretendardRegular
        
    var name: String {
        switch self {
        case .esamanruBold:
            return "esamanru OTF Bold"
        case .pretendardSemiBold:
            return "Pretendard-SemiBold"
        case .pretendardBold:
            return "Pretendard-Bold"
        case .pretendardMedium:
            return "Pretendard-Medium"
        case .pretendardRegular:
            return "Pretendard-Regular"
        }
    }
}

enum CustomTextStyle {
    case header1
    case header1_2
    case header2
    case header3
    case header4
    case header5
    case header6
    case body1
    case body2
    case body3
    case caption
    
}
