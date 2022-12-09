//
//  APICaller.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/11/21.
//

import Foundation

enum APIError: Error {
    case HTTPError
    case DataParsingError
}

class APICaller {
    // 공통 url 주소
    private static let baseURL = "http://158.247.222.189:12232"
    
    // Get Data
    static func requestGetData<T: Codable>(url: String, dataType: T.Type) async throws -> Any  {
        let url = URL(string: baseURL + url)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.HTTPError }
        guard let output = try? JSONDecoder().decode(dataType, from: data) else { throw APIError.DataParsingError }
        
        return output
    }
    
    static func requestPutData<T: Codable>(url: String, dataType: T.Type) async throws -> T  {
        let url = URL(string: baseURL + url)
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.HTTPError }
        guard let output = try? JSONDecoder().decode(dataType, from: data) else { throw APIError.DataParsingError }
        
        return output
    }
}
