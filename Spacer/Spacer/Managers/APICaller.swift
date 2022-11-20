//
//  APICaller.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/11/21.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    private let baseURL = "http://158.247.222.189:12232"
    
    // API로 데이터 요청
    func requestGetData(url: String, dataType: DataType, completionHandler: @escaping (Bool, Any) -> Void) {
        guard let url = URL(string: baseURL + url) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            guard let output = try? JSONDecoder().decode(Cafeinfo.self, from: data) else {
                print("Error: JSON Data Parsing failed")
                return
            }
            
            completionHandler(true, output)
        }.resume()
    }
    
}
