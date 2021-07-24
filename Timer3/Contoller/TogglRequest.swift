//
//  TogglRequest.swift
//  Timer2
//
//  Created by Ryan Rosica on 5/17/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import Combine


struct TogglRequest <T: Decodable> {
    enum BaseURL: String {
        case toggl = "https://api.track.toggl.com/api/v8/"
        case reports = "https://api.track.toggl.com/reports/api/v2/"
    }

    
    var endpoint: URLEndpoint
    var httpMethod: HTTPMethod
    var auth: String? = AuthManager.apiKey
    var data: Data?
    var dataWrapper: DataWrapper?
    var base =  BaseURL.toggl
    

    var publisher: AnyPublisher<T?, TogglAPIError>? {
        guard let request = request else { return nil }
        return APIClient().run(request)
            .map(\.value)
            .mapError{ .init(from: $0) }
            .timeout(.seconds(4), scheduler: DispatchQueue.main, options: nil, customError: {TogglAPIError.network})
            .eraseToAnyPublisher()
    }
    
    private var request: URLRequest? {
        guard let auth = self.auth else {
            return nil
        }
        let url = URL(string: "\(base.rawValue)\(endpoint.value())")!
        let token = auth
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.value()
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let data = self.dataWrapper?.encodedData {
            request.httpBody = data
        }
        return request
    }
    
    
    
    func fetch (completionHandler: @escaping (TogglResponse<T>) -> Void) {
        guard let auth = self.auth else {
            completionHandler(.error(.invalid))
            return
        }
        
        let url = URL(string: "\(base.rawValue)\(endpoint.value())")!
        let token = auth
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.value()
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let data = self.data {
            request.httpBody = data
        }
        
        let config = URLSessionConfiguration.default

        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completionHandler(.error(.network))
                return
            }
            
            if let data = data {
                if let object = try? JSONDecoder().decode(T.self, from: data) {
                    completionHandler(.success(object))
                }
                else {
                    completionHandler(.error(.invalid))
                }
            }
            
        })
        task.resume()
    }
    
    
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
