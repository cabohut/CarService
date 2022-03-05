//
//  AppNavigation.swift
//  CarService
//
//  Created by sam on 2/28/22.
//

import SwiftUI

struct AppNavigation: View {
    @EnvironmentObject var model: Model
    @State private var selection: Tab = .tab1
    
    enum Tab {
        case tab1
        case tab2
        case tab3
        case tab4
    }
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                ServiceHistory()
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
        AppNavigation()
    }
}
