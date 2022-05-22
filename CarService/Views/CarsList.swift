//
//  Cars.swift
//  CarService
//
//  Created by sam on 2/26/22.
//

import SwiftUI

struct CarsList: View {
    @Binding var cars: [Car]
    let saveAction: ()->Void
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresentingCarForm = false
    @State private var newCarRecord = Car()
    
    var body: some View {
        List {
            if (cars.count>0) {
                ForEach($cars) { $rec in
                    NavigationLink(destination:CarForm(rec: $rec)) {
                        CarRow(rec: rec)
                    }
                } .onDelete { indices in
                    cars.remove(atOffsets: indices)
                }
            } else {
                EmptyView()
            }
        } .navigationTitle("Cars")
            .toolbar {
                Button(action: {
                    isPresentingCarForm = true
                    newCarRecord = Car()
                }) {
                    Image(systemName: "plus")
                }
            } .sheet(isPresented: $isPresentingCarForm) {
                NavigationView {
                    CarForm(rec: $newCarRecord)
                        .navigationTitle("Car Details")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingCarForm = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    cars.append(newCarRecord)
                                    cars = cars.sorted {
                                        $0.make > $1.make}
                                    isPresentingCarForm = false
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

struct Cars_Previews: PreviewProvider {
    static var previews: some View {
        CarsList(cars: .constant([Car]()), saveAction: {})
    }
}
