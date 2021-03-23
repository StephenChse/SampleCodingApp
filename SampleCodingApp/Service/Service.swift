//
//  Service.swift
//  SampleCodingApp
//
//  Created by Stephen on  23/03/21.
//

import Foundation


enum NetworkError: Error {
    case malformedURL(message:String)
    case errorWith(response:URLResponse?)
    case dataParsinFailed(message:String)
    case networkNotAvailalbe(message:String)

}

typealias CompletonHandler<T:Decodable> =  ((Result<[T], NetworkError>) -> Void)

protocol Servicable:JsonDecodable {
    func fetchData<T:Codable>(restClient:RestClient,type:T.Type, completionHandler:@escaping CompletonHandler<T>)
}

extension Servicable {
    func fetchData<T:Codable>(restClient:RestClient,type:T.Type, completionHandler:@escaping CompletonHandler<T>) {
      
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
            guard let data = data , let _responce = responce as? HTTPURLResponse , _responce.statusCode == 200 else {
                completionHandler(.failure(.errorWith(response: responce)))
                return
            }
            // Parsing data using JsonDecoder
            if let result = decode(input:data, type:T.self) {
                completionHandler(.success(result))
            }else {
                completionHandler(.failure(.dataParsinFailed(message:"Result is Empty")))
            }
        }
        dataTask.resume()
    }
}

class Service: Servicable {
    
}
