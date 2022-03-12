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

    @State private var isPresentingServiceView = false
    @State private var newServiceRecord = Service()
    
    var body: some View {
        List {
            ForEach(Car.allCases) { c in
                if (services.filter({ $0.car == c }).count>0) {
                    Section (content: {
                        ForEach($services) { $rec in
                            if rec.car == c {
                                NavigationLink (destination: //ServiceView(rec: $rec)){
                                    ServiceForm(rec: $rec)) {
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
                    isPresentingServiceView = true
                    newServiceRecord = Service()
                }) {
                    Image(systemName: "plus")
                }
            } .sheet(isPresented: $isPresentingServiceView) {
                NavigationView {
                    ServiceForm(rec: $newServiceRecord)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingServiceView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    services.append(newServiceRecord)
                                    isPresentingServiceView = false
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

