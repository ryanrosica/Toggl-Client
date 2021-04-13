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
    
    enum Endpoint {
        case currentTimeEntry
        case timeEntry(Int)
        case startTimer
        case stopRunning(Int)
        case project(Int)
        case user
        case timeEntries (String, String)
        case projects
        case bulkTimeEntries ([Int])
        
        func value() -> String {
            switch self {
                case .currentTimeEntry:
                    return "time_entries/current"
                case .timeEntry(let id):
                    return "time_entries/\(id)"
                case .startTimer:
                    return "time_entries/start"
                case .stopRunning (let id):
                    return "time_entries/\(id)/stop"
                case .project (let id):
                    return "projects/\(id)"
                case .user:
                    return "me?with_related_data=true"
                case .timeEntries (let startDate, let endDate):
                    return "time_entries?start_date=\(startDate)&end_date=\(endDate)"
                case .bulkTimeEntries(let ids):
                    let idsStrings = ids.map{ String($0) }
                    return "time_entries/\(idsStrings.joined(separator: ","))"
                case .projects:
                    return "projects"

            }
        }
    }
    
    var endpoint: Endpoint
    var httpMethod: HTTPMethod
    var auth: String? = AuthManager.apiKey
    var data: Data?
    var dataWrapper: DataWrapper?
    let baseURL = "https://api.track.toggl.com/api/v8/"


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
        let url = URL(string: "\(baseURL)\(endpoint.value())")!
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
        
        let url = URL(string: "\(baseURL)\(endpoint.value())")!
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
