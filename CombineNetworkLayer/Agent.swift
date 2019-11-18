//
//  Agent.swift
//  CombineNetworkLayer
//
//  Created by Vadym Bulavin on 11/18/19.
//  Copyright © 2019 Vadym Bulavin. All rights reserved.
//

import Foundation
import Combine

struct Agent {
    let session = URLSession.shared
    
    struct Response<T> where T: Decodable {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        let dataTask = session
            .dataTaskPublisher(for: request)
        
        let value = dataTask
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { $0 as Error }
        
        let response = dataTask
            .map { $0.response }
            .mapError { $0 as Error }
        
        return Publishers.Zip(value, response)
            .map(Response.init)
            .eraseToAnyPublisher()
    }
}

