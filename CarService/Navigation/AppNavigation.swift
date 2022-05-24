//
//  AppNavigation.swift
//  CarService
//
//  Created by sam on 2/28/22.
//

import SwiftUI
private var DEBUG = false

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

struct AppNavigation: View {
    @Binding var cars: [Car]
    
    @State private var fileDataLoaded = false
    @State private var selection: Tab = .tab1
    @State private var errorWrapper: ErrorWrapper?
    
    enum Tab {
        case tab1
        case tab2
        case tab3
        case tab4
    }
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                ServicesHistory(cars: $cars) {
                    Task {
                        do {
                            try await ServicesStore.save(cars: cars)
                        } catch {
                            errorWrapper = ErrorWrapper(error: Error.self as! Error, guidance: "Try again later.")
                        }
                    }
                }
            } .navigationViewStyle(.stack)
                .tabItem {
                    Label ("Service", systemImage: "clock")
                }
                .task {
                    if fileDataLoaded == false {
                        do {
                            cars = try await ServicesStore.load()
                            if DEBUG {
                                //services = Service.sampleServices
                                cars = Car.sampleData
                            }
                            cars = cars.sorted {
                                $0.make > $1.make}
                            fileDataLoaded = true
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "CarService will load sample data and continue.")
                        }
                    }
                }
                .sheet(item: $errorWrapper, onDismiss: {
                    // encountered an error and need to load the sample data
                    cars = Car.sampleData
                }) { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
            
            NavigationView {
                Minder()
            } .navigationViewStyle(.stack)
                .tabItem {
                    Label ("Minder", systemImage: "exclamationmark.triangle")
                }
            
            NavigationView {
                CarsList(cars: $cars, saveAction: {})
            } .navigationViewStyle(.stack)
                .tabItem {
                    Label ("Cars", systemImage: "car.2.fill")
                }
        } .accentColor(.orange)
    }
}

struct AppNavigation_Preview: PreviewProvider {
    static var previews: some View {
        //AppNavigation(services: .constant(Service.sampleServices), cars: .constant(Car.sampleData))
        AppNavigation(cars: .constant(Car.sampleData))
    }
}
