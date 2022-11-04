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
    func getMockData() -> [CafeInfo] {
        print(#function)
        return MockParser.load([CafeInfo].self, from: "CafeInfoData") ?? [CafeInfo(
            ID: "0000000",
            name: "cafe name",
            imageInfos: [ImageInfo(images: ["CELEBER_Logo"], category: "category", productSize: "10cmx20cm")],
            locationID: 1,
            address: "Full Address",
            shortAddress: "Short Address",
            numberOfFavorites: 727,
            numberOfTables: 27,
            phoneNumber: "010-0000-0000",
            SNS: SNSList(insta: "@instaID", twitter: "@twitterID"),
            weekdayTime: "11:00~20:00",
            weekendTime: "10:00~22:00",
            dayOff: "격주로 수요일 휴무",
            eventElement: [false, false, false, false, false, false, true, true, true, true, true, true],
            cost: 0,
            additionalInfo: "카페 사장님이 작성하는 카페에 관한 추가 정보",
            reviews: [CafeReview(reviewID: 0, userID: "0000", userNickname: "User Nickname", date: Date(), selectedLabel: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], images: ["CELEBER_Logo"], text: "Review")]
                                                                
        )]
        
    }
}
