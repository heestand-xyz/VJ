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
    let relativeCornerRadius: CGFloat
    @Binding var on: Bool
    var hint: Bool
    var body: some View {
        ZStack {
            Poly(count: count, relativeCornerRadius: relativeCornerRadius)
                .foregroundColor(on ? .white : .clear)
            if hint {
                Poly(count: count, relativeCornerRadius: relativeCornerRadius)
                    .stroke()
                    .foregroundColor(.white)
            }
        }
    }
}

struct PolyView_Previews: PreviewProvider {
    static var previews: some View {
        PolyView(count: 6, relativeCornerRadius: 0.0, on: .constant(true), hint: true)
    }
}
