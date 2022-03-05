//
//  ServiceDetail.swift
//  CarService
//
//  Created by sam on 2/27/22.
//

import SwiftUI

struct ServiceDetail: View {
    var rec: Service
    
    @State private var showSheet = false
    @State private var editMode = EditMode.inactive
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                ServiceRecord()
            } .navigationTitle("Service Record")
        } .environmentObject(rec)
            .navigationViewStyle(.stack)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) { Text("Done") }
                }
            }
    }
}

struct ServiceDetail_Preview: PreviewProvider {
    static var previews: some View {
        ServiceDetail(rec: Service())
    }
}
