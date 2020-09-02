//
//  TestPattern.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-18.
//

import SwiftUI
import PolyKit

struct TestPattern: View {
    var body: some View {
        ZStack {
            Color.black
            HStack {
                Poly(count: 4)
                    .stroke()
                    .foregroundColor(.white)
                Spacer()
            }
            HStack {
                Spacer()
                Poly(count: 4)
                    .stroke()
                    .foregroundColor(.white)
            }
            Poly(count: 6)
                .stroke()
                .foregroundColor(.white)
            Rectangle()
                .foregroundColor(.clear)
                .border(Color.white)
                .frame(width: 1)
            GeometryReader { geo in
                ZStack {
                    Color.clear
                    Rectangle()
                        .foregroundColor(.clear)
                        .border(Color.white)
                        .frame(width: geo.size.width - (geo.size.height / 2), height: geo.size.height / 2)
                    Rectangle()
                        .foregroundColor(.clear)
                        .border(Color.white)
                        .frame(width: geo.size.height * 2 - geo.size.width, height: 1)
//                    Circle()
//                        .stroke(Color.white)
//                        .frame(width: geo.size.height * 2 - geo.size.width, height: geo.size.height * 2 - geo.size.width)
                }
            }
        }
        .border(Color.white)
    }
}

struct TestPattern_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            TestPattern()
                .aspectRatio(VideoJockey.aspectRatio, contentMode: .fit)
        }
    }
}
