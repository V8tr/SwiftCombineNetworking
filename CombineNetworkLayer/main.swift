//
//  main.swift
//  CombineNetworkLayer
//
//  Created by Vadym Bulavin on 11/15/19.
//  Copyright © 2019 Vadym Bulavin. All rights reserved.
//

import Foundation
import Combine

let storage = Storage()
let agent = Agent()

// MARK: - Sequence

let savedUser = agent.login(username: "U1", password: "P1")
    .handleEvents(receiveOutput: storage.save) // Side effects

let orders = savedUser
    .flatMap(agent.orders(by:))
    .replaceError(with: [])
    .sink(receiveCompletion: { _ in },
          receiveValue: { orders in print(orders) })

// MARK: - Parallel

let orderId = 1

let orderDetails = agent.orderDetails(orderId: orderId)
let shipmentStatus = agent.orderShipmentStatus(orderId: orderId)

let fullData = Publishers.Zip(orderDetails, shipmentStatus)
    .sink(receiveCompletion: { _ in },
          receiveValue: { details, shipment in () })
