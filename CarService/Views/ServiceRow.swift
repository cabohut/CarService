//
//  ServiceRow.swift
//  CarService
//
//  Created by sam on 2/27/22.
//

import SwiftUI

struct ServiceRow: View {
    @StateObject var rec: Service
    
    var body: some View {
        HStack {
            rec.type.img()
                .font(.system(size: 28))
                .foregroundColor(.blue)
                .frame(alignment: .leading)

            VStack (alignment: .leading) {
                HStack {
                    Text(rec.car.rawValue.capitalized)
                        .fontWeight(.bold)
                    Spacer()
                    Text(rec.type.rawValue.capitalized)
                }
                HStack {
                    Text(rec.date.formatted(date: .numeric, time: .omitted))
                    Spacer()
                    Text(String(rec.milage))
                        .frame(alignment: .trailing)
                }
            }
        }
    }
}

struct ServiceRow_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ServiceRow(rec: Service())
        } .previewLayout(.fixed(width: 300, height: 70))
    }
}
