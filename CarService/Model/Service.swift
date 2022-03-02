//
//  Service.swift
//  CarService
//
//  Created by sam on 2/27/22.
//

import Foundation

struct Service: Hashable, Codable, Identifiable {
    var id = UUID()
    var date: Date
    var car: Car
    var type: ServiceType
    var milage: Int
    var details: String = ""
    var vendor: String = ""
    var cost: Float = 0.0
    
    static func addServiceRecord() -> Service {
        let new = Service(date: Date(), car: Car.porsche, type: ServiceType.oil, milage: 99999, cost: 99.99)
        return new
    }
}

enum Car: String, Identifiable, CaseIterable, Codable {
    case porsche, lexus, nissan
    var id: Self { self }
}

enum ServiceType: String, Identifiable, CaseIterable, Codable {
    case oil = "Oil Change"
    case tires = "New Tires"
    case rotate = "Rotate Tires"
    case battery = "New Battery"
    case brakes = "Brakes"
    
    var id: Self { self }
}
