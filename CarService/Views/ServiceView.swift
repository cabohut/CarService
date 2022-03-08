//
//  ServiceView.swift
//  CarService
//
//  Created by sam on 2/27/22.
//

import SwiftUI

struct ServiceView: View {
    @Binding var rec: Service

    @State private var isPresentingServiceView = false
    @State private var data = Service()
    
    var body: some View {
        NavigationView {
            Text("hi")
        }
        .navigationTitle("Editing View")
        .toolbar {
            Button("Edit") {
                isPresentingServiceView = true
                data = rec.data
            }
        }
        .sheet(isPresented: $isPresentingServiceView) {
            NavigationView {
                ServiceRecord(rec: $data)
                    .navigationTitle(Text("Hey"))
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

struct ServiceView_Preview: PreviewProvider {
    static var previews: some View {
        ServiceView(rec: .constant(Service()))
    }
}
