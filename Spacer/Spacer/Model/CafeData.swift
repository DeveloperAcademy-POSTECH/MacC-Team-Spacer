//
//  CafeData.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/11/21.
//

import Foundation

// 개별 카페 정보
struct Cafeinfo: Codable {
    let cafeID: String
    let cafeShortAddress: String
    let numberOfTables: Int
    let cafeCost: String
    let cafeLocation: Int
    let cafeName: String
    let cafeAddress: String
    let numberOfFavorites: Int
    let cafePhoneNumber: String
    let cafeAdditionalDescription: String
    let cafeOpenURL: String
}

// 카페의 SNS 정보
struct CafeSNSInfo: Codable {
    let twitter: String?
    let instagram: String?
}

// 카페 영업시간
struct CafeOpenings: Codable {
    let cafeWeekdayTime: String
    let cafeWeekendTime: String
    let cafeDayOff: String
}
