//
//  ServicesStore.swift
//  CarService
//
//  Created by sam on 3/7/22.
//  Code from Scrumdinger sample app
//  https://developer.apple.com/tutorials/app-dev-training/persisting-data

import Foundation
import SwiftUI

let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let archiveURL = documentsDirectory.appendingPathComponent("car service").appendingPathExtension("plist")

class ServicesStore: ObservableObject {
    @Published var services: [Service] = []
    @Published var cars: [Car] = []
    
    // MARK: Save/Load data
    // Scrumdinger methods below
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("services.data")
    }
    
    static func load() async throws -> [Service] {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let services):
                    continuation.resume(returning: services)
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<[Service], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let services = try JSONDecoder().decode([Service].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(services))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func save(services: [Service]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(services: services) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let servicesSaved):
                    continuation.resume(returning: servicesSaved)
                }
            }
        }
    }
    
    static func save(services: [Service], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(services)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(services.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
