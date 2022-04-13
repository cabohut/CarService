//
//  ServiceRow.swift
//  CarService
//
//  Created by sam on 2/27/22.
//

import SwiftUI

struct ServiceRow: View {
    let rec: Service
    
    var body: some View {
        HStack {
            rec.type.img()
                .foregroundColor(.orange)
                .frame(width: 30, alignment: .center)
                .font(Font.system(size: 22, weight: .regular))

            VStack {
                Text(rec.date.formatted(date: .abbreviated, time: .omitted))
                    .frame(width: 160, alignment: .leading)
                if rec.details.isEmpty {
                    Text(rec.type.rawValue.capitalized)
                        .frame(width: 160, alignment: .leading)
                        .foregroundColor(.gray)
                        .font(.caption)
                } else {
                    Text(rec.type.rawValue.capitalized + ", " + rec.details)
                        .frame(width: 160, alignment: .leading)
                        .foregroundColor(.gray)
                        .font(.caption)
                } 
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
