//
//  CircleView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-12.
//

import SwiftUI

struct CircleView: View {
    @Binding var on: Bool
    var body: some View {
        ZStack {
            let width: CGFloat = 10
            Circle()
                .foregroundColor(on ? .primary : .clear)
                .padding(width)
            Circle()
                .strokeBorder(lineWidth: width)
                .foregroundColor(on ? .clear : .primary)
        }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(on: .constant(true))
    }
}
