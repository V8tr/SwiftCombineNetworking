//
//  Github.swift
//  CombineNetworkLayer
//
//  Created by Vadym Bulavin on 11/19/19.
//  Copyright © 2019 Vadym Bulavin. All rights reserved.
//

import Foundation
import Combine

enum GithubAPI {
    static let agent = Agent()
    static let base = URL(string: "https://api.github.com")!
}

extension GithubAPI {
        
    static func repos(username: String) -> AnyPublisher<[Repository], Error> {
        return run(URLRequest(url: base.appendingPathComponent("users/\(username)/repos")))
    }
    
    static func issues(repo: String, owner: String) -> AnyPublisher<[Issue], Error> {
        return run(URLRequest(url: base.appendingPathComponent("repos/\(owner)/\(repo)/issues")))
    }
    
    static func repos(org: String) -> AnyPublisher<[Repository], Error> {
        return run(URLRequest(url: base.appendingPathComponent("orgs/\(org)/repos")))
    }
    
    static func members(org: String) -> AnyPublisher<[User], Error> {
        return run(URLRequest(url: base.appendingPathComponent("orgs/\(org)/members")))
    }
    
    static func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

