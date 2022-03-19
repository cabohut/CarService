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
    @State private var filterValue = 1
    
    func earliestServiceMonths() -> Int {
        let earliestDate = services.min(by: { $0.date < $1.date})?.date
        return Calendar.current.dateComponents([.month], from: earliestDate ?? Date(), to: Date()).month ?? 0
    }
    
    var body: some View {
        List {
            HStack {
                Text("Filter (months)")
                
                Picker(selection: $filterValue, label: Text("")) {
                    Text("off").tag(1)
                    Text("3").tag(2)
                    Text("6").tag(3)
                    Text("12").tag(4)
                }.pickerStyle(.segmented)
            } .font(.caption)
            
            let numMonths = earliestServiceMonths()
            if numMonths > 1 {
                 Toggle (isOn: $onlyRecent) {
                 Text("Filter Records")
                 }.toggleStyle(.switch)
                
                if onlyRecent {
                    Stepper("Showing the last \(filterValue) \((filterValue > 1) ? "months" : "month")", value: $filterValue, in: 1...numMonths+1) .font(.caption)
                }
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
