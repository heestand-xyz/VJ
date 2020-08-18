//
//  CircleView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-12.
//

import SwiftUI

struct CircleView: View {
    @Binding var on: Bool
    var hint: Bool
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(on ? .white : .clear)
            if hint {
                Circle()
                    .strokeBorder()
                    .foregroundColor(.white)
            }
        }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(on: .constant(true), hint: true)
    }
}
