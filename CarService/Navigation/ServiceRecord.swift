//
//  ServiceRecord.swift
//  CarService
//
//  Created by sam on 3/2/22.
//

import SwiftUI

struct ServiceRecord: View {
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
        List {
            // Date
            HStack {
                Text("Date")
                DatePicker(selection: $iDate,displayedComponents: .date, label: {}) .padding()
            } .padding([.top,.bottom], -14)
            
            Section {
                // Car
                Picker("Car", selection: $iCar) {
                    ForEach(Car.allCases) { c in
                        Text(String(c.rawValue.capitalized)).tag(c)
                    }
                }
                
                // Service Type
                Picker("Service Type", selection: $iType) {
                    ForEach(ServiceType.allCases) { t in
                        Text(t.rawValue.capitalized).tag(t)
                    }
                }
            }
            
            Section {
                // Milage
                HStack {
                    Text("Milage")
                    padding()
                    TextField("", value: $iMilage, formatter: NumberFormatter())
                        .padding(3)
                        .frame(width: 160)
                        .multilineTextAlignment(.center)
                        .background(Color(0xF2F2F7, alpha: 0.3))
                }
                
                // Vendor
                HStack {
                    Text("Vendor")
                    padding()
                    TextField("", text: $iVendor)
                        .padding(3)
                        .frame(width: 160)
                        .multilineTextAlignment(.center)
                        .background(Color(0xF2F2F7, alpha: 0.3))
                }
                
                // Cost
                HStack {
                    Text("Cost")
                    padding()
                    TextField("", value: $iCost, formatter: NumberFormatter())
                        .padding(3)
                        .frame(width: 160)
                        .multilineTextAlignment(.center)
                        .background(Color(0xF2F2F7, alpha: 0.3))
                }
                
            }
            // Service Details
            Section (header: Text("Service Details")){
                TextField("", text: $iDetails)
            }
        } // list
    } // body
} // struct

struct ServiceRecord_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ServiceRecord()
        }
    }
}
