//
//  HexView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-29.
//

import SwiftUI

struct HexView: View {
    
    let hint: Bool
    
    let asCircle: Bool
    
    @Binding var onVJ: Bool
    @Binding var onDJ: Bool
    
    @Binding var flow: CGFloat
    var flowAmp: CGFloat = 0.01
    
    @Binding var corner: CGFloat
    
    var cornerFlow: Binding<CGFloat> {
        Binding<CGFloat> {
            corner + flow * flowAmp
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
                CircleView(onVJ: $onVJ, onDJ: $onDJ, hint: hint)
                    .blendMode(.difference)
            } else {
                PolyView(count: 6, corner: cornerFlow, onVJ: $onVJ, onDJ: $onDJ, hint: hint)
            }
        }
            .frame(width: length,
                   height: length)
            .frame(width: width,
                   height: height)
        .onInteract(on: $onVJ, drag: Binding<CGVector>(get: { .zero }, set: { vector in
            flow = vector.dy
        }))
            .offset(x: isOddRow ? width / 2 : 0.0)
            .opacity(!isOutside ? 1.0 : 0.0)
    }
    
}

//struct HexView_Previews: PreviewProvider {
//    static var previews: some View {
//        HexView()
//    }
//}
