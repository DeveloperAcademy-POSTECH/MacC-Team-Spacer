//
//  MockParser.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/12.
//

import Foundation

private class MockParser {
    // type: 디코딩 할 때 사용되는 모델의 타입, resourceName: json 파일의 이름
    
    static func load<D: Codable>(_ type: D.Type, from resourceName: String) -> D? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "json") else {
            return nil
        }
        
        guard let jsonString = try? String(contentsOfFile: path) else {
            return nil
        }
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        guard let data = data else { return nil }
        
        do {
            let lastData = try decoder.decode(type, from: data)
            return lastData
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return nil
    }
}

class MockManager {
    static let shared = MockManager()
    private init() {}
    func getMockData() -> [CafeInfoModel] {
        print(#function)
        return MockParser.load([CafeInfoModel].self, from: "CafeInfoData") ?? [CafeInfoModel(
            cafeID: 0,
            cafeName: "cafeName",
            imageDirectories: ["CELEBER_Logo"],
            cafeAddress: "cafeAddress",
            cafePhoneNumber: "010-2715-5629",
            SNS: SNSList(
                insta: "instaID",
                         twitter: "twitterID",
                         facebook: "facebookID",
                         homepage: "homepageURL"
                        ),
            weekdayTime: "1200~2000",
            saturdayTime: "1200~2000",
            sundayTime: "1200~2000",
            holidayTime: "1200~2000",
            cafeDayOff: "안쉽니다",
            cafeMinPeople: 0,
            cafeMaxPeople: 20,
            cafeCosts: nil,
            locationID: nil,
            cafeStarRating: 3.5,
            cafeEventElement: [0,3,7],
            cafeAdditionalInfo: "기타 사항 쓰기")
        ]
        
    }
}
