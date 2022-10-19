//
//  MockParser.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/12.
//

import Foundation

class MockParser {
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
        return MockParser.load([CafeInfo].self, from: "DummyData") ?? [CafeInfo(cafe_id: 0, cafe_name: "랑카페", image_directories: ["RANG"], address: "포항 남구", cafe_phone_number: "010-1111-2222", sns: nil, cafe_min_people: 20, cafe_max_people: 50, costs: nil, location_id: 0, cafe_star_rating: 3.5)]
    }
}
