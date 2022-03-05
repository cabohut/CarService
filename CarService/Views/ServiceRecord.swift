//
//  ServiceRecord.swift
//  CarService
//
//  Created by sam on 3/2/22.
//

import SwiftUI

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}

// custom modifier
struct _TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(3)
            .frame(width: 160)
            .multilineTextAlignment(.center)
            .background(Color(0xF2F2F7, alpha: 0.3))
    }
}

struct ServiceRecord: View {
    @EnvironmentObject var model: Model
    @EnvironmentObject var rec: Service
    
    var body: some View {
        List {
            Section {
                // Date
                HStack {
                    Text("Date")
                    DatePicker("", selection: $rec.date,displayedComponents: [.date])
                }
                
                // Car
                Picker("Car", selection: $rec.car) {
                    ForEach(Car.allCases) { c in
                        Text(String(c.rawValue.capitalized)).tag(c)
                    }
                }
                
                // Service Type
                Picker("Service Type", selection: $rec.type) {
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
                    TextField("Service Milage", value: $rec.milage, format: .number)
                        .keyboardType(.numberPad)
                        .modifier(_TextFieldModifier())
                }
                
                // Vendor
                HStack {
                    Text("Vendor")
                    padding()
                    TextField("Vendor Name", text: $rec.vendor)
                        .modifier(_TextFieldModifier())
               }
                
                // Cost
                HStack {
                    Text("Cost")
                    padding()
                    TextField("Total Cost", value: $rec.cost, formatter: NumberFormatter.currency)
                        .keyboardType(.decimalPad)
                        .modifier(_TextFieldModifier())
                }
            }

            // Service Details
            Section (header: Text("Service Details")){
                TextField("Enter Details", text: $rec.details)
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
