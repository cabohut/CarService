//
//  ServiceDetail.swift
//  CarService
//
//  Created by sam on 2/27/22.
//

import SwiftUI

struct ServiceDetail: View {
    var svc: Service
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(svc.type.rawValue) .font(.title)
                Text(svc.date.formatted(date: .numeric, time: .omitted))
            }
        }
        .navigationTitle(svc.car.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ServiceDetail_Preview: PreviewProvider {
    static var previews: some View {
        ServiceDetail(svc: Model().records[0])
    }
}
