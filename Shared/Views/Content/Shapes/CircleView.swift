//
//  CircleView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-12.
//

import SwiftUI

struct CircleView: View {
    @Binding var onVJ: Bool
    @Binding var onDJ: Bool
    var hint: Bool
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(onVJ && onDJ ? .white : .clear)
            if hint || onVJ {
                Circle()
                    .strokeBorder()
                    .foregroundColor(.white)
            }
        }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(onVJ: .constant(true), onDJ: .constant(true), hint: true)
    }
}
