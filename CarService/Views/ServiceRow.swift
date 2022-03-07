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
                .font(.system(size: 20))
                .foregroundColor(.blue)
                .frame(width: 30, alignment: .leading)
            
            VStack {
                Text(rec.type.rawValue.capitalized)
                    .bold()
                    .frame(width: 160, alignment: .leading)
                Text(rec.date.formatted(date: .abbreviated, time: .omitted))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Spacer()
            
            Text("\(rec.milage ?? 0)").padding(.trailing, 5)
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
