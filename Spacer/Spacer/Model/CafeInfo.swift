//
//  CafeInfo.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/12.
//

import Foundation

struct CafeInfo: Codable {
    let cafe_id: Int
    let cafe_name: String
    let image_directories: [String]
    let address: String
    let cafe_phone_number: String
    let sns: String?
    let cafe_min_people: Int
    let cafe_max_people: Int
    let costs: Int?
    let location_id: Int
    let cafe_star_rating: Double

}
