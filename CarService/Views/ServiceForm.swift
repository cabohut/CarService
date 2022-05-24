//
//  ServiceForm.swift
//  CarService
//
//  Created by sam on 3/2/22.
//

import SwiftUI

let currencyFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.numberStyle = .currency
    return f
} ()

struct ServiceForm: View {
    //@Binding var rec: Service
    @Binding var car: Car
    //@Binding var log: Log

    var body: some View {
        List {
            Section {
                // Car
                Picker("Car", selection: $car.unique) {
                    ForEach(Car2.allCases) { c in
                        Text(c.rawValue.capitalized).tag(c)
                    }
                }
                
                // Date
                HStack {
                    Text("Date")
                    DatePicker("", selection: $log.date,displayedComponents: [.date])
                }
                
                // Service Type
                Picker("Service Type", selection: $log.type) {
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
                    TextField("Milage", value: $log.milage, format: .number)
                        .keyboardType(.numberPad)
                        .modifier(_TextFieldModifier())
                }
                
                // Vendor
                HStack {
                    Text("Vendor")
                    padding()
                    TextField("Vendor Name", text: $log.vendor)
                        .modifier(_TextFieldModifier())
               }
                
                // Cost
                HStack {
                    Text("Cost")
                    padding()
                    TextField("Total Cost", value: $log.cost, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .modifier(_TextFieldModifier())
                }
            }

            // Service Details
            Section (header: Text("Service Details")){
                TextField("Enter Details", text: $log.details)
            }
        } // list
    } // body
} // struct

struct ServiceForm_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ServiceForm(log: .constant(Log()))
        }
    }
}
