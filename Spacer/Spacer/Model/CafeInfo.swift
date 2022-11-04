//
//  CafeInfo.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/12.
//

import Foundation

struct CafeInfo: Codable {
    let ID: String
    let name: String
    let imageInfos: [ImageInfo]
    let locationID: Int
    let address: String
    let shortAddress: String
    let numberOfFavorites: Int
    let numberOfTables: Int
    let phoneNumber: String
    let SNS: SNSList
    let weekdayTime: String
    let weekendTime: String
    let dayOff: String?
    let eventElement: [Bool]
    let cost: Int
    let additionalInfo: String?
    let reviews: [CafeReview]?
}

struct SNSList: Codable {
    let insta: String?
    let twitter: String?
}

struct ImageInfo: Codable {
    let images: [String]
    let category: String
    let productSize: String
}

struct CafeReview: Codable {
    let reviewID: Int
    let userID: String
    let userNickname: String
    let date: Date
    let selectedLabel: [Int]?
    let images: [String]?
    let text: String
}

