//
//  Minder.swift
//  CarService
//
//  Created by sam on 2/26/22.
//

import SwiftUI

struct Minder: View {
    enum Flavor: String, CaseIterable, Identifiable {
        case chocolate, vanilla, strawberry
        var id: Self { self }
    }

    @State private var selectedFlavor: Flavor = .chocolate
    @State private var iCost: Int=0

    var body: some View {
        VStack {
            List {
                Picker("Flavor", selection: $selectedFlavor) {
                    ForEach(Flavor.allCases) { flavor in
                        Text(flavor.rawValue.capitalized)
                    }
                }
                HStack {
                    Text("Cost")
                    padding()
                }
            }
        } 
    }
}

struct Minder_Previews: PreviewProvider {
    static var previews: some View {
        Minder()
    }
}

