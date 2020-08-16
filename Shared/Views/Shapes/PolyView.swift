//
//  PolyView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI
import PolyKit

struct PolyView: View {
    let count: Int
    @Binding var on: Bool
    var hint: Bool
    var body: some View {
        ZStack {
            Poly(count: count)
                .foregroundColor(on ? .white : .clear)
            if hint {
                Poly(count: count)
                    .stroke()
                    .foregroundColor(.white)
            }
        }
    }
}

struct PolyView_Previews: PreviewProvider {
    static var previews: some View {
        PolyView(count: 6, on: .constant(true), hint: true)
    }
}
