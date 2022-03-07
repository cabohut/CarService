//
//  ServiceHistory.swift
//  CarService
//
//  Created by sam on 2/26/22.
//

import SwiftUI

struct ServiceHistory: View {
    @EnvironmentObject var model: Model
    
    @State private var showSheet = false
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        List {
            ForEach(Car.allCases) { c in
                if (model.records.filter({ $0.car == c }).count>0) {
                    Section (content: {
                        ForEach(model.records) { rec in
                            if rec.car == c {
                                NavigationLink (destination: ServiceDetail(rec: rec)){
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
                /*
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton().font(.headline)
                }
                 */
                //ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {showSheet.toggle()}) {
                        if !editMode.isEditing {
                            Image(systemName: "plus")
                        }
                    }
                //}
            } .sheet(isPresented: $showSheet) {
                ServiceAdd()
            }
    }
    
    private func onDelete(at offsets: IndexSet) {
        model.records.remove(atOffsets: offsets)
        Model.saveToFile(records: model.records)
    }
}

struct ServiceHistory_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Menu4()
        }
    }
}

