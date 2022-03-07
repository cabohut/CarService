//
//  Service.swift
//  CarService
//
//  Created by sam on 2/27/22.
//

import Foundation
import SwiftUI

class Service: ObservableObject, Identifiable {
    var id: UUID = UUID()
    @Published var date: Date = Date()
    @Published var car: Car = Car.porsche
    @Published var type: ServiceType = ServiceType.oil
    @Published var milage: Int?
    @Published var details: String = ""
    @Published var vendor: String = ""
    @Published var cost: Float?    
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

