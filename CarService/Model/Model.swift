//
//  Model.swift
//  CarService
//
//  Created by sam on 2/26/22.
//

import SwiftUI

let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let archiveURL = documentsDirectory.appendingPathComponent("car service").appendingPathExtension("plist")

final class Model: ObservableObject {
    @Published var records: [Service] = []
    
    init() {
        // records = sampleData()
        // records = readFromFile()
    }
    
    // MARK: Save/Load data
    // from App Development with Swift Book, section 4.7 Saving Data (p. 663)
    static func saveToFile (records: [Service]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedFile = try? propertyListEncoder.encode(records)
        try? encodedFile?.write(to: archiveURL, options: .noFileProtection)
    }
    
    private func readFromFile () -> [Service] {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedFileData = try? Data(contentsOf: archiveURL),
            let decodedFile = try? propertyListDecoder.decode(Array<Service>.self, from: retrievedFileData) {
            return decodedFile
        }
        return []
    }
    
    // MARK: return sample data
    private func sampleData() -> [Service] {
        let testData = [
            Service(id: UUID(), date: Date(), car: Car.lexus, type: ServiceType.oil, milage: 0, details: "", vendor: "", cost: 0.0),
            Service(id: UUID(), date: Date(), car: Car.porsche, type: ServiceType.brakes, milage: 0, details: "", vendor: "", cost: 0.0),
            Service(id: UUID(), date: Date(), car: Car.nissan, type: ServiceType.tires, milage: 0, details: "", vendor: "", cost: 0.0),
            Service(id: UUID(), date: Date(), car: Car.porsche, type: ServiceType.rotate, milage: 0, details: "", vendor: "", cost: 0.0),
            Service(id: UUID(), date: Date(), car: Car.nissan, type: ServiceType.oil, milage: 0, details: "", vendor: "", cost: 0.0),
            Service(id: UUID(), date: Date(), car: Car.lexus, type: ServiceType.brakes, milage: 0, details: "", vendor: "", cost: 0.0),
            Service(id: UUID(), date: Date(), car: Car.lexus, type: ServiceType.tires, milage: 0, details: "", vendor: "", cost: 0.0),
            Service(id: UUID(), date: Date(), car: Car.nissan, type: ServiceType.oil, milage: 0, details: "", vendor: "", cost: 0.0),
            Service(id: UUID(), date: Date(), car: Car.porsche, type: ServiceType.rotate, milage: 0, details: "", vendor: "", cost: 0.0)]
       return testData
    }
}

extension Color {
    // https://bit.ly/3cUKorw
    init(_ hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}
