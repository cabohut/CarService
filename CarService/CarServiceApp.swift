//
//  CarServiceApp.swift
//  CarService
//
//  Created by sam on 2/26/22.
//

import SwiftUI

@main
struct CarServiceApp: App {
    @StateObject private var model = Model()
    
    var body: some Scene {
        WindowGroup {
            AppNavigation()
                .environmentObject(model)
        }
    }
}
