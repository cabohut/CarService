//
//  Service.swift
//  CarService
//
//  Created by sam on 2/27/22.
//

import Foundation
import SwiftUI

struct Service: Identifiable, Codable {
    var id: UUID = UUID()
    var date: Date = Date()
    var car: Car = Car.porsche
    var type: ServiceType = ServiceType.oil
    var milage: Int?
    var details: String = ""
    var vendor: String = ""
    var cost: Float?    
}

extension Service {
    var data: Service {
        Service(date: date, car: car, type: type, milage: milage, details: details, vendor: vendor, cost: cost)
    }
    
    mutating func update(from data: Service) {
        date = data.date
        car = data.car
        type = data.type
        milage = data.milage
        details = data.details
        vendor = data.vendor
        cost = data.cost
    }
}

enum Car: String, Identifiable, CaseIterable, Codable {
    var id: String { self.rawValue }
    
    case porsche
    case lexus
    case nissan
    
}

enum ServiceType: String, Identifiable, CaseIterable, Codable {
    var id: String { self.rawValue }

    case oil = "Oil Change"
    case tires = "New Tires"
    case rotate = "Rotate Tires"
    case battery = "New Battery"
    case brakes = "Brakes"
    
    func img() -> Image {
        switch self {
        case .oil:
            return Image(systemName: "sun.max.circle.fill")
        case .tires:
            return Image(systemName: "tortoise.fill")
        case .rotate:
            return Image(systemName: "figure.walk.diamond.fill")
        case .battery:
            return Image(systemName: "minus.plus.batteryblock.fill")
        case .brakes:
            return Image(systemName: "dollarsign.square")
        }
    }

}

extension Service {
    // MARK: return sample data
    static let sampleData: [Service] = [
        Service(date: Date(), car: Car.porsche, type: ServiceType.oil, milage: 5423, details: "", vendor: "Vendor A", cost: 234.95),
        Service(date: Date(), car: Car.lexus, type: ServiceType.oil, milage: 1245, details: "", vendor: "", cost: 34.95),
        Service(date: Date(), car: Car.porsche, type: ServiceType.brakes, milage: 53876, details: "", vendor: "", cost: 763.22),
        Service(date: Date(), car: Car.nissan, type: ServiceType.tires, milage: 14325, details: "", vendor: "", cost: 0.0),
        Service(date: Date(), car: Car.porsche, type: ServiceType.rotate, milage: 7654, details: "", vendor: "", cost: 0.0),
        Service(date: Date(), car: Car.nissan, type: ServiceType.oil, milage: 54690, details: "", vendor: "", cost: 0.0),
        Service(date: Date(), car: Car.lexus, type: ServiceType.brakes, milage: 54321, details: "", vendor: "", cost: 0.0),
        Service(date: Date(), car: Car.lexus, type: ServiceType.tires, milage: 84756, details: "", vendor: "", cost: 0.0),
        Service(date: Date(), car: Car.nissan, type: ServiceType.oil, milage: 12345, details: "", vendor: "", cost: 0.0),
        Service(date: Date(), car: Car.porsche, type: ServiceType.rotate, milage: 14674, details: "", vendor: "", cost: 0.0)
    ]
}
