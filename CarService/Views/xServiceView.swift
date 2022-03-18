//
//  xServiceView.swift
//  CarService
//
//  Created by sam on 2/27/22.
//

import SwiftUI

struct xServiceView: View {
    @Binding var rec: Service
    
    @State private var isPresentingServiceView = false
    @State private var data = Service()
    
    var body: some View {
        NavigationView {
            List {
                rec.type.img()
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                
                Text(rec.date.formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                    .font(.caption)
                
                Text(rec.type.rawValue.capitalized)
                
                Text("\(rec.milage ?? 0)")
                
                Text(rec.vendor)
                
                Text("\(rec.cost ?? 0)")
            }
        }
        .navigationTitle(Text(rec.car.rawValue.capitalized))
        .toolbar {
            Button("Edit") {
                isPresentingServiceView = true
                data = rec.data
            }
        }
        .sheet(isPresented: $isPresentingServiceView) {
            NavigationView {
                ServiceForm(rec: $data)
                    .navigationTitle(Text(data.type.rawValue))
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingServiceView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingServiceView = false
                                rec.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct xServiceView_Preview: PreviewProvider {
    static var previews: some View {
        xServiceView(rec: .constant(Service()))
    }
}
