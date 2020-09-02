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
    @Binding var corner: CGFloat
    @Binding var onVJ: Bool
    @Binding var onDJ: Bool
    var hint: Bool
    var body: some View {
        ZStack {
            Poly(count: count, relativeCornerRadius: corner)
                .foregroundColor(onVJ && onDJ ? .white : .clear)
            if hint || onVJ {
                Poly(count: count, relativeCornerRadius: corner)
                    .stroke(lineWidth: hint && onVJ ? 2.0 : 1.0)
                    .foregroundColor(.white)
            }
        }
    }
}

struct PolyView_Previews: PreviewProvider {
    static var previews: some View {
        PolyView(count: 6, corner: .constant(0.0), onVJ: .constant(true), onDJ: .constant(true), hint: true)
    }
}
