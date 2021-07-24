//
//  APIClient.swift
//  TogglTimer3
//
//  Created by Ryan Rosica on 8/17/20.
//  Copyright © 2020 Ryan Rosica. All rights reserved.
//

import Foundation
import Combine

struct APIClient {
    
    let successCode = 200
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    struct URLResponseError: Error {
        var response: URLResponse
        init (response: URLResponse) {
            self.response = response
            
        }
    }
    
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T?>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T?> in
                
                if let result = result.response as? HTTPURLResponse {

                    if result.statusCode != successCode {
                        print("DA CODE \(result.statusCode)")
                        throw URLResponseError(response: result)
                    }
                }
                

                let value = try? JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
                
                
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
