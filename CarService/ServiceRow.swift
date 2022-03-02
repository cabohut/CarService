//
//  ServiceRow.swift
//  CarService
//
//  Created by sam on 2/27/22.
//

import SwiftUI

struct ServiceRow: View {
    var svc: Service
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(svc.car.rawValue)
            HStack {
                Text(svc.date.formatted(date: .numeric, time: .omitted))
                Spacer()
                Text(svc.type.rawValue)
            }
        }
    }
}

struct ServiceRow_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ServiceRow(svc: Model().records[0])
            ServiceRow(svc: Model().records[1])
        } .previewLayout(.fixed(width: 300, height: 70))
    }
}
