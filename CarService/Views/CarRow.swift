//
//  CarRow.swift
//  CarService
//
//  Created by bugs on 5/20/22.
//

import SwiftUI

struct CarRow: View {
    let rec: Car
    
    var body: some View {
        HStack {
//            rec.type.img()
//                .foregroundColor(.orange)
//                .frame(width: 30, alignment: .center)
//                .font(Font.system(size: 22, weight: .regular))

            VStack {
                Text("\(rec.year)").padding(.trailing, 5)
                Text("\(rec.make)").padding(.trailing, 5)
                Text("\(rec.model)").padding(.trailing, 5)

            }
        }
    }
}

struct CarRow_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            CarRow(rec: Car())
        } .previewLayout(.fixed(width: 300, height: 70))
    }
}
