//
//  ServicesHistory.swift
//  CarService
//
//  Created by sam on 2/26/22.
//

import SwiftUI

struct ServicesHistory: View {
    @Binding var services: [Service]
    let saveAction: ()->Void
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresentingServiceForm = false
    @State private var newServiceRecord = Service()
    @State private var onlyRecent = false
    @State private var filterValue = 6
    let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -6, to: Date())
    
    func inRange(interval: Int) -> Bool {
        
        return true
    }
    
    var body: some View {
        List {
            Toggle (isOn: $onlyRecent) {
                Text("Filter Records")
            }.toggleStyle(.switch)
            
            if onlyRecent {
                let str = (filterValue > 1) ? "months" : "month"
                Stepper("\(filterValue) " + str, value: $filterValue, in: 1...600)
            }
            
            ForEach(Car.allCases) { c in
                if (services.filter({ $0.car == c }).count>0) {
                    Section (content: {
                        ForEach($services) { $rec in
                            if (rec.car == c) && (!onlyRecent || (onlyRecent && rec.date > Calendar.current.date(byAdding: .month, value: -filterValue, to: Date())! )) {
                                NavigationLink(destination:ServiceForm(rec: $rec)) {
                                    ServiceRow(rec: rec)
                                }
                            } else {
                                EmptyView()
                            }
                        } .onDelete { indices in
                            services.remove(atOffsets: indices)
                        }
                    }, header: { Text(c.rawValue) })
                } else {
                    EmptyView()
                }
            }
        } .navigationTitle("Service History")
            .toolbar {
                Button(action: {
                    isPresentingServiceForm = true
                    newServiceRecord = Service()
                }) {
                    Image(systemName: "plus")
                }
            } .sheet(isPresented: $isPresentingServiceForm) {
                NavigationView {
                    ServiceForm(rec: $newServiceRecord)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingServiceForm = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    services.append(newServiceRecord)
                                    isPresentingServiceForm = false
                                }
                            }
                        }
                }
            } // .sheet
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
    }
}

struct ServiceHistory_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ServicesHistory(services: .constant([Service]()), saveAction: {})
        }
    }
}
