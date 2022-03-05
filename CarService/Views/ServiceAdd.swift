//
//  ServiceAdd.swift
//  CarService
//
//  Created by sam on 2/28/22.
//

import SwiftUI

struct ServiceAdd: View {
    @EnvironmentObject var model: Model
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @StateObject var rec : Service = Service()
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                // Show service record form
                ServiceRecord()
                
                HStack { // action buttons
                    Button(action: {()
                        presentationMode.wrappedValue.dismiss()
                    }) { Text("Cancel")}
                    
                    Spacer()
                    
                    Button(action: {
                        addNewService()
                        presentationMode.wrappedValue.dismiss()
                    }) { Text("Add") }
                } .padding()
            } .navigationTitle("New Service Record")
        } .environmentObject(rec)
          .navigationViewStyle(.stack)
    }
    
    private func addNewService () {
        model.records += [rec]
        Model.saveToFile(records: model.records)
    }
}

struct ServiceAdd_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ServiceAdd()
        }
    }
}
