//
//  Service.swift
//  CarService
//
//  Created by sam on 2/27/22.
//

import Foundation

struct Service: Identifiable, Codable {
    var id: UUID = UUID()
    var date: Date = Date()
    var car: Car = Car.porsche
    var type: ServiceType = ServiceType.oil
    var milage: Int = 0
    var details: String = ""
    var vendor: String = ""
    var cost: Float = 1.99
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
