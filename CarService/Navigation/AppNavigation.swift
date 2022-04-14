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
    @Binding var services: [Service]
    
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
                ServicesHistory(services: $services) {
                    Task {
                        do {
                            try await ServicesStore.save(services: services)
                        } catch {
                            errorWrapper = ErrorWrapper(error: Error.self as! Error, guidance: "Try again later.")
                        }
                    }
                }
            } .navigationViewStyle(.stack)
                .tabItem {
                    Label ("History", systemImage: "list.bullet")
                }
                .task {
                    if fileDataLoaded == false {
                        do {
                            services = try await ServicesStore.load()
                            if DEBUG {
                                services = Service.sampleData
                            }
                            services = services.sorted {
                                $0.date > $1.date }
                            fileDataLoaded = true
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "CarService will load sample data and continue.")
                        }
                    }
                }
                .sheet(item: $errorWrapper, onDismiss: {
                    // encountered an error and need to load the sample data
                    services = Service.sampleData
                }) { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
            
            NavigationView {
                Menu2()
            } .navigationViewStyle(.stack)
                .tabItem {
                    Label ("Menu 2", systemImage: "heart.fill")
                }
            
            NavigationView {
                Menu3()
            } .navigationViewStyle(.stack)
                .tabItem {
                    Label ("Menu 3", systemImage: "seal.fill")
                }
            
            NavigationView {
                Menu4()
            } .navigationViewStyle(.stack)
                .tabItem {
                    Label ("Menu 4", systemImage: "book.closed.fill")
                }
        }
    }
}

struct AppNavigation_Preview: PreviewProvider {
    static var previews: some View {
        AppNavigation(services: .constant(Service.sampleData))
    }
}
