//
//  ServicesHistory.swift
//  CarService
//
//  Created by sam on 2/26/22.
//

import SwiftUI

struct ServicesHistory: View {
    @Binding var cars: [Car]
    
    let saveAction: ()->Void
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresentingServiceForm = false
    //@State private var newServiceRecord = Service()
    @State private var newLogRecord = Log()
    @State private var dateFilter = 0
 
    func notFiltered(dt: Date, filter: Int) -> Bool {
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

//            List {
//                ForEach(Car2.allCases) { c in
//                    if (services.filter({ $0.car == c }).count>0) {
//                        Section (content: {
//                            ForEach($services) { $rec in
//                                if (rec.car == c) && okToShow(dt: rec.date, filter: dateFilter) {
//                                    NavigationLink(destination:ServiceForm(rec: $rec)) {
//                                        ServiceRow(rec: rec)
//                                    }
//                                } else {
//                                    EmptyView()
//                                }
//                            } .onDelete { indices in
//                                services.remove(atOffsets: indices)
//                            }
//                        }, header: { Text(c.rawValue) })
//                    } else {
//                        EmptyView()
//                    }
//                }
//            }

            
            List {
                ForEach($cars) { c in
                    if (c.logs.count>0) {
                        Section (content: {
                            ForEach(c.logs) { $rec in
                               if (notFiltered(dt: rec.date, filter: dateFilter)) {
                                   NavigationLink(destination:ServiceForm(car: c, log: $rec)) {
                                        ServiceRow(rec: rec)
                                    }
                                } else {
                                    EmptyView()
                                }
                            } .onDelete { indices in
                                cars.remove(atOffsets: indices)
                            }
                        }, header: { Text("**** Car Name Here") })
                    } else {
                        EmptyView()
                    }
                }
            }
            .navigationTitle("Service History")
            .toolbar {
                Button(action: {
                    isPresentingServiceForm = true
                    newLogRecord = Log()
                }) {
                    Image(systemName: "plus")
                }
            } .sheet(isPresented: $isPresentingServiceForm) {
                NavigationView {
                    ServiceForm(car: c, log: $newLogRecord)
                        .navigationTitle("Service Details")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingServiceForm = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    // ***** cars.logs.append(newLogRecord)
                                    cars = cars.sorted {
                                        $0.make > $1.make }
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
            ServicesHistory(cars: .constant([Car]()), saveAction: {})
        }
    }
}
