//
//  Model.swift
//  CombineNetworkLayer
//
//  Created by Vadym Bulavin on 11/18/19.
//  Copyright © 2019 Vadym Bulavin. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
}

struct Repository: Codable {
    let id: Int
    let name: String
    let description: String?
}

struct Issue: Codable {
    let id: Int
}
