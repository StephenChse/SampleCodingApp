//
//  MockService.swift
//  SampleCodingAppTests
//
//  Created by Stephen on 23/03/21.
//

import Foundation
@testable import SampleCodingApp

class MockService: Servicable, JsonDecodable {
    var responseFileName = ""
    func fetchData<T:Codable>(restClient:RestClient,type:T.Type, completionHandler:@escaping Completion<T>) {
        // Obtain Reference to Bundle
        let bundle = Bundle(for:MockService.self)
        
        guard let url = bundle.url(forResource:responseFileName, withExtension:"json"),
              let data = try? Data(contentsOf: url),
              let output = decode(input:data, type:T.self)
        else {
            completionHandler(.failure(ApiError.parsinFailed(message:"Failed to get response")))
            return
        }
        completionHandler(.success(output))
    }
}
