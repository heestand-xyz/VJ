//
//  FinalView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-21.
//

import SwiftUI

struct FinalView: View {
    
    @ObservedObject var vj: VideoJockey
    
    var output: some View {
        OutputView(vj: vj)
            .compositingGroup()
            .blendMode(.multiply)
    }
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                Color.black
                
                Group {
                    
                    ZStack {
                        Color(hue: 0.0, saturation: 1.0, brightness: 1.0)
                        output
                    }
                    .offset(x: -vj.colorShift)
                    
                    ZStack {
                        Color(hue: 1.0 / 3.0, saturation: 1.0, brightness: 1.0)
                        output
                    }
                    
                    ZStack {
                        Color(hue: 2.0 / 3.0, saturation: 1.0, brightness: 1.0)
                        output
                    }
                    .offset(x: vj.colorShift)
                    
                }
                .aspectRatio(vj.aspectRatio, contentMode: .fit)
                .padding(vj.padding * geo.size.height)
                .compositingGroup()
                .blendMode(.screen)
            }
            .compositingGroup()
            .blur(radius: vj.blur * geo.size.height * 0.01)
            
        }
        
    }
    
//    var body: some View {
//
//        GeometryReader { geo in
//
//            ZStack {
//
//                Color.black
//
//                colorShifted
//                    .compositingGroup()
//                    .blur(radius: vj.blur * geo.size.height * 0.01)
////                    .opacity(0.5)
//
////                colorShifted
////                    .blendMode(.screen)
//
//            }
//
//        }
//
//    }
    
}

struct FinalView_Previews: PreviewProvider {
    static var previews: some View {
        FinalView(vj: VideoJockey())
    }
}
