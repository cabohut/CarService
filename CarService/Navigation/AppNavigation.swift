//
//  AppNavigation.swift
//  CarService
//
//  Created by sam on 2/28/22.
//

import SwiftUI

struct AppNavigation: View {
    @Binding var services: [Service]
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
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }

                }
            } .navigationViewStyle(.stack)
            .tabItem {
                let menuText = Text("History", comment: "List of previous services")
                Label {
                    menuText
                } icon: {
                    Image(systemName: "list.bullet")
                }.accessibility(label: menuText)
            }
            .tag(Tab.tab1)
            
            NavigationView {
                Menu2()
            } .navigationViewStyle(.stack)
            .tabItem {
                let menuText = Text("Menu 2", comment: "Menu 2 description")
                Label {
                    menuText
                } icon: {
                    Image(systemName: "heart.fill")
                }.accessibility(label: menuText)
            }
            .tag(Tab.tab2)

            NavigationView {
                Menu3()
            } .navigationViewStyle(.stack)
            .tabItem {
                let menuText = Text("Menu 3", comment: "Menu 3 description")
                Label {
                    menuText
                } icon: {
                    Image(systemName: "seal.fill")
                }.accessibility(label: menuText)
            }
            .tag(Tab.tab3)

            NavigationView {
                Menu4()
            } .navigationViewStyle(.stack)
            .tabItem {
                let menuText = Text("Menu 4", comment: "Menu 4 description")
                Label {
                    menuText
                } icon: {
                    Image(systemName: "book.closed.fill")
                }.accessibility(label: menuText)
            }
            .tag(Tab.tab4)
        } // .environmentObject(model)
    }
}

struct AppNavigation_Preview: PreviewProvider {
    static var previews: some View {
        AppNavigation(services: .constant(Service.sampleData))
    }
}
