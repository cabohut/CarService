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
            ForEach (model.records) { rec in
                NavigationLink {
                    ServiceDetail(svc: rec)
                        .environmentObject(model)
                } label: {
                    ServiceRow(svc: rec)
                }
            } .onDelete(perform: onDelete)
        } .navigationBarTitle("Service History", displayMode: .inline)
            .navigationBarItems(leading: EditButton().font(.headline), trailing:
                                    Button(action: {showSheet.toggle()}) {
                if !editMode.isEditing {
                    Image(systemName: "plus")
                }
            } .sheet(isPresented: $showSheet) {
                ServiceAdd().environmentObject(model)
            }) .environment(\.editMode, $editMode)
    }
    
    private func onDelete(at offsets: IndexSet) {
        model.records.remove(atOffsets: offsets)
        Model.saveToFile(records: model.records)
    }
}

struct ServiceHistory_Previews: PreviewProvider {
    static var previews: some View {
        ServiceHistory()
    }
}

