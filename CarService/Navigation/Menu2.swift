//
//  Menu2.swift
//  CarService
//
//  Created by sam on 2/26/22.
//

import SwiftUI

struct Menu2: View {
    @EnvironmentObject var model: Model
    
    enum Flavor: String, CaseIterable, Identifiable {
        case chocolate, vanilla, strawberry
        var id: Self { self }
    }

    enum Car2: String, Identifiable, CaseIterable, Codable {
        case porsche, lexus, nissan
        var id: Self { self }
    }


    @State private var selectedFlavor: Flavor = .chocolate
    @State private var selectedCar: Car2 = .porsche
    @State private var selectedService: ServiceType = .oil
    @State private var iMilage: Int=0

    var body: some View {
        VStack {
            List {
                Picker("Flavor", selection: $selectedFlavor) {
                    ForEach(Flavor.allCases) { flavor in
                        Text(flavor.rawValue.capitalized)
                    }
                }
                HStack {
                    Text("Milage")
                    padding()
                    TextField("Milage", value: $iMilage, formatter: NumberFormatter())
                        .padding(5)
                        .multilineTextAlignment(.center)
                        .background(Color(0x8ed293, alpha: 0.3))

                }
            }
        } 
    }
}

struct Menu2_Previews: PreviewProvider {
    static var previews: some View {
        Menu2()
    }
}

