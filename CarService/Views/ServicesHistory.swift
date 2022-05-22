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
    @State private var dateFilter = 0

    func okToShow(dt: Date, filter: Int) -> Bool {
        return filter == 0 || (filter > 0 && dt > Calendar.current.date(byAdding: .month, value: -filter, to: Date())! )
    }
    
    var body: some View {
        VStack {
            HStack {
                Picker(selection: $dateFilter, label: Text("")) {
                    Text("All").tag(0)
                    Text("3 mon").tag(3)
                    Text("6 mon").tag(6)
                    Text("One year").tag(12)
                }.pickerStyle(.segmented)
                    .font(.caption)
            } .padding([.bottom, .top], 5)
                .padding([.leading, .trailing], 10)

            List {
                ForEach(Car2.allCases) { c in
                    if (services.filter({ $0.car == c }).count>0) {
                        Section (content: {
                            ForEach($services) { $rec in
                                if (rec.car == c) && okToShow(dt: rec.date, filter: dateFilter) {
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
                        .navigationTitle("Service Details")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingServiceForm = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    services.append(newServiceRecord)
                                    services = services.sorted {
                                        $0.date > $1.date }
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
}

struct ServiceHistory_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ServicesHistory(services: .constant([Service]()), saveAction: {})
        }
    }
}
