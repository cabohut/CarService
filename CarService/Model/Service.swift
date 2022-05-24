//
//  Service.swift
//  CarService
//
//  Created by sam on 2/27/22.
//

import Foundation
import SwiftUI

// custom modifier
struct _TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(3)
            .frame(width: 160)
            .multilineTextAlignment(.center)
            .background(Color(0xF2F2F7, alpha: 0.3))
    }
}

struct Service: Identifiable, Codable, Comparable {
    static func < (lhs: Service, rhs: Service) -> Bool {
        return lhs.date > rhs.date
    }
    
    var id: UUID = UUID()
    var date: Date = Date()
    var car: Car2 = Car2.porsche
    var type: ServiceType = ServiceType.odometer
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

struct Log: Identifiable, Codable, Comparable {
    static func < (lhs: Log, rhs: Log) -> Bool {
        return lhs.date > rhs.date
    }
    
    var id: UUID = UUID()
    var date: Date = Date()
    var type: LogType = LogType.odometer
    var milage: Int?
    var details: String = ""
    var vendor: String = ""
    var cost: Float?
}

extension Log {
    var data: Log {
        Log(date: date, type: type, milage: milage, details: details, vendor: vendor, cost: cost)
    }
    
    mutating func update(from data: Log) {
        date = data.date
        type = data.type
        milage = data.milage
        details = data.details
        vendor = data.vendor
        cost = data.cost
    }
}

struct Car: Identifiable, Codable, Comparable {
    static func < (lhs: Car, rhs: Car) -> Bool {
        return lhs.make > rhs.make
    }
    
    var id: UUID = UUID()
    var year: String = ""
    var make: String = ""
    var model: String = ""
    var unique: String = ""
    var logs: [Log] = []
}

extension Car {
    var data: Car {
        Car(year: year, make: make, model: model, unique: unique, logs: logs)
    }
    
    mutating func update(from data: Car) {
        year = data.year
        make = data.make
        model = data.model
        unique = data.unique
        logs = data.logs
    }
}

enum Car2: String, Identifiable, CaseIterable, Codable {
    var id: String { self.rawValue }
    
    case porsche = "Porsche"
    case lexus = "Lexus"
    case nissan = "Nissan"
}

enum ServiceType: String, Identifiable, CaseIterable, Codable {
    var id: String { self.rawValue }

    case odometer = "Odometer"
    case oil = "Oil Change"
    case tires = "New Tires"
    case rotate = "Rotate Tires"
    case battery = "New Battery"
    case brakes = "Brakes"
    case smog = "Smog Check"
    case alignment = "Alignment"
    case other = "Other"
    
    func img() -> Image {
        switch self {
        case .odometer:
            return Image("service.odometer")
        case .oil:
            return Image("service.oil")
        case .tires:
            return Image("service.tires")
        case .rotate:
            return Image("service.rotate-tires")
        case .battery:
            return Image(systemName: "minus.plus.batteryblock")
        case .brakes:
            return Image("service.brakes")
        case .smog:
            return Image(systemName: "checkmark.seal")
        case .alignment:
            return Image("service.alignment")
        case .other:
            return Image(systemName: "wrench")
        }
    }
}

enum LogType: String, Identifiable, CaseIterable, Codable {
    var id: String { self.rawValue }

    case odometer = "Odometer"
    case oil = "Oil Change"
    case tires = "New Tires"
    case rotate = "Rotate Tires"
    case battery = "New Battery"
    case brakes = "Brakes"
    case smog = "Smog Check"
    case alignment = "Alignment"
    case other = "Other"
    
    func img() -> Image {
        switch self {
        case .odometer:
            return Image("service.odometer")
        case .oil:
            return Image("service.oil")
        case .tires:
            return Image("service.tires")
        case .rotate:
            return Image("service.rotate-tires")
        case .battery:
            return Image(systemName: "minus.plus.batteryblock")
        case .brakes:
            return Image("service.brakes")
        case .smog:
            return Image(systemName: "checkmark.seal")
        case .alignment:
            return Image("service.alignment")
        case .other:
            return Image(systemName: "wrench")
        }
    }
}

func convertDate(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.date(from: date) ?? Date()
}


extension Service {
    // MARK: return sample data
    static let sampleServices: [Service] = [
        Service(date: convertDate(date: "2022-03-31"), car: Car2.lexus, type: ServiceType.brakes, milage: 105185, details: "", vendor: "Roo", cost: 600.00),
        Service(date: convertDate(date: "2022-03-30"), car: Car2.lexus, type: ServiceType.oil, milage: 105150, details: "", vendor: "Evans", cost: 78.00),
        Service(date: convertDate(date: "2021-07-21"), car: Car2.lexus, type: ServiceType.tires, milage: 97965, details: "", vendor: "Costco", cost: 671.27),
        Service(date: convertDate(date: "2021-08-10"), car: Car2.lexus, type: ServiceType.smog, milage: 98207, details: "", vendor: "Akon Auto Center", cost: 48.20),
        Service(date: convertDate(date: "2021-08-10"), car: Car2.lexus, type: ServiceType.alignment, milage: 98196, details: "", vendor: "EDZ Tires", cost: 59.00),
        Service(date: convertDate(date: "2020-12-27"), car: Car2.lexus, type: ServiceType.oil, milage: 92633, details: "", vendor: "Valvoline Scripps Ranch", cost: 72.82),
        Service(date: convertDate(date: "2019-08-13"), car: Car2.lexus, type: ServiceType.smog, milage: 82676, details: "", vendor: "Antonio", cost: 40.00),
        Service(date: convertDate(date: "2018-11-18"), car: Car2.lexus, type: ServiceType.tires, milage: 75627, details: "", vendor: "Costco", cost: 9999.99),
        Service(date: convertDate(date: "2018-07-17"), car: Car2.lexus, type: ServiceType.battery, milage: 72940, details: "", vendor: "Costco", cost: 105.59),
        Service(date: convertDate(date: "2018-07-18"), car: Car2.lexus, type: ServiceType.other, milage: 72947, details: "Service", vendor: "Roo Automotive", cost: 135.00),
        Service(date: convertDate(date: "2016-11-18"), car: Car2.lexus, type: ServiceType.oil, milage: 55089, details: "", vendor: "RB Automotive", cost: 99.89),
        Service(date: convertDate(date: "2016-07-01"), car: Car2.lexus, type: ServiceType.oil, milage: 50155, details: "", vendor: "RB Automotive", cost: 99.89),
        Service(date: convertDate(date: "2018-05-17"), car: Car2.lexus, type: ServiceType.oil, milage: 71258, details: "", vendor: "Valvoline Scripps Ranch", cost: 75.01),
        Service(date: convertDate(date: "2018-12-17"), car: Car2.lexus, type: ServiceType.oil, milage: 76547, details: "", vendor: "Valvoline Scripps Ranch", cost: 72.82),
        Service(date: convertDate(date: "2021-09-19"), car: Car2.lexus, type: ServiceType.oil, milage: 99420, details: "", vendor: "Valvoline Scripps Ranch", cost: 55.48),

        Service(date: convertDate(date: "2021-06-28"), car: Car2.nissan, type: ServiceType.oil, milage: 69612, details: "", vendor: "Valvoline", cost: 41.71),
        Service(date: convertDate(date: "2021-02-22"), car: Car2.nissan, type: ServiceType.oil, milage: 61568, details: "", vendor: "Valvoline", cost: 47.09),
        Service(date: convertDate(date: "2019-02-09"), car: Car2.nissan, type: ServiceType.oil, milage: 22071, details: "", vendor: "Valvoline", cost: 65.91),
        Service(date: convertDate(date: "2019-05-27"), car: Car2.nissan, type: ServiceType.oil, milage: 27811, details: "", vendor: "Valvoline", cost: 65.90),
        Service(date: convertDate(date: "2019-12-31"), car: Car2.nissan, type: ServiceType.oil, milage: 38753, details: "", vendor: "Valvoline", cost: 67.03),
        Service(date: convertDate(date: "2020-07-10"), car: Car2.nissan, type: ServiceType.oil, milage: 47524, details: "", vendor: "Valvoline", cost: 40.63),
        Service(date: convertDate(date: "2018-10-05"), car: Car2.nissan, type: ServiceType.oil, milage: 14315, details: "", vendor: "Mossy Nissan", cost: 65.29),
        Service(date: convertDate(date: "2018-06-25"), car: Car2.nissan, type: ServiceType.oil, milage: 8500, details: "", vendor: "Antonio's", cost: 92.26),
        Service(date: convertDate(date: "2019-02-13"), car: Car2.nissan, type: ServiceType.tires, milage: 22233, details: "(2) Michelin Defender 235/65R18", vendor: "Discount Tire", cost: 464.66),
        Service(date: convertDate(date: "2019-07-06"), car: Car2.nissan, type: ServiceType.tires, milage: 30000, details: "(2) Michelin Defender 235/65R18", vendor: "Discount Tire", cost: 457.42),
        Service(date: convertDate(date: "2019-12-24"), car: Car2.nissan, type: ServiceType.rotate, milage: 38239, details: "", vendor: "Discount Tire", cost: 0),
        Service(date: convertDate(date: "2021-12-16"), car: Car2.nissan, type: ServiceType.odometer, milage: 77220, details: "ABS recall", vendor: "Mossy Nissan", cost: 0),

        Service(date: convertDate(date: "2022-04-12"), car: Car2.porsche, type: ServiceType.odometer, milage: 80000, details: "", vendor: "", cost: 0),
        Service(date: convertDate(date: "2021-08-05"), car: Car2.porsche, type: ServiceType.oil, milage: 78497, details: "", vendor: "Performance", cost: 159.24),
        Service(date: convertDate(date: "2018-12-19"), car: Car2.porsche, type: ServiceType.oil, milage: 72292, details: "", vendor: "Performance", cost: 129.74),
        Service(date: convertDate(date: "2018-01-12"), car: Car2.porsche, type: ServiceType.oil, milage: 67314, details: "", vendor: "Performance", cost: 131.89),
        Service(date: convertDate(date: "2017-04-20"), car: Car2.porsche, type: ServiceType.other, milage: 63075, details: "Window Regulator", vendor: "Performance", cost: 482.31),
        Service(date: convertDate(date: "2017-02-21"), car: Car2.porsche, type: ServiceType.other, milage: 62553, details: "Purchased from Rob Chong", vendor: "Performance", cost: 22700),
    ]
}

extension Car {
    // MARK: return sample data
    static let sampleData: [Car] = [
        Car(year: "2012", make: "Lexus", model: "IS250", logs: [
            Log(date: convertDate(date: "2022-03-31"), type: LogType.brakes, milage: 105185, details: "", vendor: "Roo", cost: 600.00),
            Log(date: convertDate(date: "2022-03-30"), type: LogType.oil, milage: 105150, details: "", vendor: "Evans", cost: 78.00),
            Log(date: convertDate(date: "2021-07-21"), type: LogType.tires, milage: 97965, details: "", vendor: "Costco", cost: 671.27),
            Log(date: convertDate(date: "2021-08-10"), type: LogType.smog, milage: 98207, details: "", vendor: "Akon Auto Center", cost: 48.20),
            Log(date: convertDate(date: "2021-08-10"), type: LogType.alignment, milage: 98196, details: "", vendor: "EDZ Tires", cost: 59.00),
            Log(date: convertDate(date: "2020-12-27"), type: LogType.oil, milage: 92633, details: "", vendor: "Valvoline Scripps Ranch", cost: 72.82),
            Log(date: convertDate(date: "2019-08-13"), type: LogType.smog, milage: 82676, details: "", vendor: "Antonio", cost: 40.00),
            Log(date: convertDate(date: "2018-11-18"), type: LogType.tires, milage: 75627, details: "", vendor: "Costco", cost: 9999.99),
            Log(date: convertDate(date: "2018-07-17"), type: LogType.battery, milage: 72940, details: "", vendor: "Costco", cost: 105.59),
            Log(date: convertDate(date: "2018-07-18"), type: LogType.other, milage: 72947, details: "Service", vendor: "Roo Automotive", cost: 135.00),
            Log(date: convertDate(date: "2016-11-18"), type: LogType.oil, milage: 55089, details: "", vendor: "RB Automotive", cost: 99.89),
            Log(date: convertDate(date: "2016-07-01"), type: LogType.oil, milage: 50155, details: "", vendor: "RB Automotive", cost: 99.89),
            Log(date: convertDate(date: "2018-05-17"), type: LogType.oil, milage: 71258, details: "", vendor: "Valvoline Scripps Ranch", cost: 75.01),
            Log(date: convertDate(date: "2018-12-17"), type: LogType.oil, milage: 76547, details: "", vendor: "Valvoline Scripps Ranch", cost: 72.82),
            Log(date: convertDate(date: "2021-09-19"), type: LogType.oil, milage: 99420, details: "", vendor: "Valvoline Scripps Ranch", cost: 55.48),
        ]),
        
        Car(year: "2018", make: "Nissan", model: "Pathfinder", logs: [
            Log(date: convertDate(date: "2021-06-28"), type: LogType.oil, milage: 69612, details: "", vendor: "Valvoline", cost: 41.71),
            Log(date: convertDate(date: "2021-02-22"), type: LogType.oil, milage: 61568, details: "", vendor: "Valvoline", cost: 47.09),
            Log(date: convertDate(date: "2019-02-09"), type: LogType.oil, milage: 22071, details: "", vendor: "Valvoline", cost: 65.91),
            Log(date: convertDate(date: "2019-05-27"), type: LogType.oil, milage: 27811, details: "", vendor: "Valvoline", cost: 65.90),
            Log(date: convertDate(date: "2019-12-31"), type: LogType.oil, milage: 38753, details: "", vendor: "Valvoline", cost: 67.03),
            Log(date: convertDate(date: "2020-07-10"), type: LogType.oil, milage: 47524, details: "", vendor: "Valvoline", cost: 40.63),
            Log(date: convertDate(date: "2018-10-05"), type: LogType.oil, milage: 14315, details: "", vendor: "Mossy Nissan", cost: 65.29),
            Log(date: convertDate(date: "2018-06-25"), type: LogType.oil, milage: 8500, details: "", vendor: "Antonio's", cost: 92.26),
            Log(date: convertDate(date: "2019-02-13"), type: LogType.tires, milage: 22233, details: "(2) Michelin Defender 235/65R18", vendor: "Discount Tire", cost: 464.66),
            Log(date: convertDate(date: "2019-07-06"), type: LogType.tires, milage: 30000, details: "(2) Michelin Defender 235/65R18", vendor: "Discount Tire", cost: 457.42),
            Log(date: convertDate(date: "2019-12-24"), type: LogType.rotate, milage: 38239, details: "", vendor: "Discount Tire", cost: 0),
            Log(date: convertDate(date: "2021-12-16"), type: LogType.odometer, milage: 77220, details: "ABS recall", vendor: "Mossy Nissan", cost: 0),
        ]),
        
        Car(year: "2006", make: "Porsche", model: "Cayman", logs:[
            Log(date: convertDate(date: "2022-04-12"), type: LogType.odometer, milage: 80000, details: "", vendor: "", cost: 0),
            Log(date: convertDate(date: "2021-08-05"), type: LogType.oil, milage: 78497, details: "", vendor: "Performance", cost: 159.24),
            Log(date: convertDate(date: "2018-12-19"), type: LogType.oil, milage: 72292, details: "", vendor: "Performance", cost: 129.74),
            Log(date: convertDate(date: "2018-01-12"), type: LogType.oil, milage: 67314, details: "", vendor: "Performance", cost: 131.89),
            Log(date: convertDate(date: "2017-04-20"), type: LogType.other, milage: 63075, details: "Window Regulator", vendor: "Performance", cost: 482.31),
            Log(date: convertDate(date: "2017-02-21"), type: LogType.other, milage: 62553, details: "Purchased from Rob Chong", vendor: "Performance", cost: 22700),
        ]),
    ]
}
