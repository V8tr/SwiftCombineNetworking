//
//  main.swift
//  CombineNetworkLayer
//
//  Created by Vadym Bulavin on 11/15/19.
//  Copyright © 2019 Vadym Bulavin. All rights reserved.
//

import Foundation
import Combine

// MARK: - Chain

func chain() {
    let me = "V8tr"
    let repos = GithubAPI.repos(username: me)
    let firstRepo = repos.compactMap { $0.first }
    let issues = firstRepo.flatMap { repo in
        GithubAPI.issues(repo: repo.name, owner: me)
    }
    
    let token = issues.sink(receiveCompletion: { _ in },
                            receiveValue: { print($0) })
    
    RunLoop.main.run(until: Date(timeIntervalSinceNow: 10))

    withExtendedLifetime(token, {})
}


// MARK: - Parallel

func parallel() {
    let members = GithubAPI.members(org: "apple")
    let repos = GithubAPI.repos(org: "apple")
    let token = Publishers.Zip(members, repos)
        .sink(receiveCompletion: { _ in },
              receiveValue: { (members, repos) in print(members, repos) })

    RunLoop.main.run(until: Date(timeIntervalSinceNow: 10))

    withExtendedLifetime(token, {})
}
