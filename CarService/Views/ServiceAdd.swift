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
    
    @State var rec : Service = Service()
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                // Show service record form
                ServiceRecord(rec: Service())
                
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
            } .navigationBarTitle("New Service Record")
        }
    }
    
    private func addNewService () {
        print(rec)
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
