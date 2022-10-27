//
//  CafeInfo.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/12.
//

import Foundation

struct CafeInfoModel: Codable {
    let cafeID: Int
    let cafeName: String
    let imageDirectories: [String]
    let cafeAddress: String
    let cafePhoneNumber: String?
    let SNS: SNSList
    let weekdayTime: String
    let saturdayTime: String?
    let sundayTime: String?
    let holidayTime: String?
    let cafeDayOff: String?
    let cafeMinPeople: Int?
    let cafeMaxPeople: Int?
    let cafeCosts: Int?
    let locationID: Int?
    let cafeStarRating: Double
    let cafeEventElement: [Int?]
    let cafeAdditionalInfo: String?
}

struct SNSList: Codable {
    let insta: String?
    let twitter: String?
    let facebook: String?
    let homepage: String?
}
