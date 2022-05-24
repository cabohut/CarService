//
//  CarServiceApp.swift
//  CarService
//
//  Created by sam on 2/26/22.
//

import SwiftUI

@main
struct CarServiceApp: App {
    @StateObject private var store = ServicesStore()
    
    var body: some Scene {        
        WindowGroup {
            //AppNavigation(services: $store.services, cars: $store.cars)
            AppNavigation(cars: $store.cars)
        }
    }
}
