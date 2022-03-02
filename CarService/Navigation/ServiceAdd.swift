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
    
    @State private var iDate = Date()
    @State private var iCar: Car = .porsche
    @State private var iType: ServiceType = .oil
    @State private var iMilage: Int=0
    @State private var iDetails = ""
    @State private var iVendor = ""
    @State private var iCost: Float=0.0
    
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
            } .navigationBarTitle("New Service Record")
        }
    }
    
    private func addNewService () {
        let new = Service(date: iDate, car: iCar, type: iType, milage: iMilage, details: iDetails,vendor: iVendor, cost: Float(iCost))
        model.records += [new]
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
