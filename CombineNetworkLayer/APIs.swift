//
//  APIs.swift
//  CombineNetworkLayer
//
//  Created by Vadym Bulavin on 11/18/19.
//  Copyright © 2019 Vadym Bulavin. All rights reserved.
//

import Foundation
import Combine

extension Agent {
    
    func login(username: String, password: String) -> AnyPublisher<User, Error> {
        var request = URLRequest(url: URL(string: "https://myapi.com/login")!)
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["username": username, "password": password])
        return run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func orders(by user: User) -> AnyPublisher<[Order], Error> {
        return run(URLRequest(url: URL(string: "https://myapi.com/orders/user/\(user.id)")!)) // GET by default
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func orderDetails(orderId: Int) -> AnyPublisher<Order, Error> {
        return run(URLRequest(url: URL(string: "https://myapi.com/orders/\(orderId)")!)) // GET by default
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func orderShipmentStatus(orderId: Int) -> AnyPublisher<ShipmentStatus, Error> {
        return run(URLRequest(url: URL(string: "https://myapi.com/orders/shipment/\(orderId)")!)) // GET by default
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
