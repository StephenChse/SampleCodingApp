//
//  Service.swift
//  SampleCodingApp
//
//  Created by Stephen on  23/03/21.
//

import Foundation

protocol Servicable:JsonDecodable {
    func fetchData<T:Codable>(restClient:RestClient,type:T.Type, completionHandler:@escaping Completion<T>)
}

enum ApiError: Error {
    case parsinFailed(message:String)
    case errorWith(message:String)
    case networkNotAvailalbe
    case malformedURL(message:String)
}

typealias Completion<T:Decodable> =  ((Result<[T], ApiError>) -> Void)

extension Servicable {
    func fetchData<T:Codable>(restClient:RestClient,type:T.Type, completionHandler:@escaping Completion<T>) {
      
        // Combining baseUrl, Path, Params using URLComponents
        guard var urlComponents = URLComponents(string:restClient.baseUrl + restClient.path) else {
            completionHandler(.failure(.malformedURL(message:"URL is not correct")))
            return
        }
        urlComponents.query = "\(restClient.params)"
        guard let url = urlComponents.url else {
            completionHandler(.failure(.malformedURL(message:"URL is nil")))
            return
        }
        let urlSesson = URLSession(configuration: .default)

        let dataTask =  urlSesson.dataTask(with:url) { (data, responce, error)  in
            guard  let _responce = responce as? HTTPURLResponse , _responce.statusCode == 200 else {
                completionHandler(.failure(.errorWith(message: "Failed to get resonce")))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.errorWith(message: "Failed to get data")))
                return
            }
            // Parsing data using JsonDecoder
            if let result = decode(input:data, type:T.self) {
                completionHandler(.success(result))
            }else {
                completionHandler(.failure(.parsinFailed(message:"Result is Empty")))
            }
        }
        dataTask.resume()
    }
}

/*Created Class to inject as dependency in veiwModel and use MockService for Unit testing*/
class Service: Servicable {
    
}
