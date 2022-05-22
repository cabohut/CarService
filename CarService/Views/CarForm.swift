//
//  CarForm.swift
//  CarService
//
//  Created by bugs on 5/20/22.
//

import SwiftUI

struct CarForm: View {
    @Binding var rec: Car
    
    var body: some View {
        List {
            //Section {
                // Year
                HStack {
                    Text("Year")
                    padding()
                    TextField("Year", text: $rec.year)
                        .keyboardType(.numberPad)
                        .modifier(_TextFieldModifier())
                }
                
                // Make
                HStack {
                    Text("Make")
                    padding()
                    TextField("Make", text: $rec.make)
                        .modifier(_TextFieldModifier())
                }
                
                // Model
                HStack {
                    Text("Model")
                    padding()
                    TextField("Model", text: $rec.model)
                        .modifier(_TextFieldModifier())
                }
            //} // section
        } // list
    } // body
} // struct

struct CarForm_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CarForm(rec: .constant(Car()))
        }
    }
}
