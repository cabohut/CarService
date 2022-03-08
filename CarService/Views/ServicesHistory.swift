//
//  ServicesHistory.swift
//  CarService
//
//  Created by sam on 2/26/22.
//

import SwiftUI

struct ServicesHistory: View {
    @Binding var services: [Service]
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresentingServiceView = false
    @State private var newServiceRecord = Service()
    
    let saveAction: ()->Void
    
    var body: some View {
        List {
            ForEach(Car.allCases) { c in
                if (services.filter({ $0.car == c }).count>0) {
                    Section (content: {
                        ForEach($services) { $rec in
                            if rec.car == c {
                                NavigationLink (destination: ServiceView(rec: $rec)){
                                    ServiceRow(rec: rec)
                                }
                            } else {
                                EmptyView()
                            }
                        } .onDelete(perform: onDelete)
                    }, header: { Text(c.rawValue) })
                } else {
                    EmptyView()
                }
            } // ForEach Car.allCases
        } .navigationTitle("Service History")
            .toolbar {
                Button(action: {
                    isPresentingServiceView = true
                    let _ = print(isPresentingServiceView)
                }) {
                    Image(systemName: "plus")
                }
            } .sheet(isPresented: $isPresentingServiceView) {
                NavigationView {
                    ServiceRecord(rec: $newServiceRecord)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingServiceView = false
                                    newServiceRecord = Service()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    services.append(newServiceRecord)
                                    isPresentingServiceView = false
                                    newServiceRecord = Service()
                                }
                            }
                        }
                }
            } //sheet
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
    }
    
    private func onDelete(at offsets: IndexSet) {
        services.remove(atOffsets: offsets)
        //Model.saveToFile(records: model.records)
    }
}

struct ServiceHistory_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ServicesHistory(services: .constant([Service]()),
                            saveAction: {})
        }
    }
}
