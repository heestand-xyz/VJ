//
//  HexView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-29.
//

import SwiftUI

struct HexView: View {
    
    @State var drag: CGVector = .zero
    var dragAmp: CGFloat = 0.01
    
    let hint: Bool
    
    let asCircle: Bool
    
    @Binding var isOn: Bool
    @Binding var corner: CGFloat
    var dragCorner: Binding<CGFloat> {
        Binding<CGFloat> {
            corner + drag.dy * dragAmp
        } set: { _ in }
    }

    let length: CGFloat
    let width: CGFloat
    let height: CGFloat
    
    let isOddRow: Bool
    let isOutside: Bool
    
    var body: some View {
        Group {
            if asCircle {
                CircleView(on: $isOn, hint: hint)
                    .blendMode(.difference)
            } else {
                PolyView(count: 6, corner: dragCorner, on: $isOn, hint: hint)
            }
        }
            .frame(width: length,
                   height: length)
            .frame(width: width,
                   height: height)
            .onInteract(on: $isOn, drag: $drag)
            .offset(x: isOddRow ? width / 2 : 0.0)
            .opacity(!isOutside ? 1.0 : 0.0)
    }
    
}

//struct HexView_Previews: PreviewProvider {
//    static var previews: some View {
//        HexView()
//    }
//}
