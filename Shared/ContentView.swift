//
//  ContentView.swift
//  Shared
//
//  Created by Cappuccino on 2020-08-12.
//

import SwiftUI
import MultiplatformTypes

struct ContentView: View {
    
    @EnvironmentObject var vj: VJModel
    
    @State var tapOnSmallCircles: [Bool] = []
    @State var tapOnBigCircles: [Bool] = []

    var body: some View {
        
        ZStack {
            
//            // Gradient Radial
//            GeometryReader { geo in
//                RadialGradient(gradient: Gradient(colors: [Color.clear, Color.primary]), center: .center, startRadius: 0.0, endRadius: geo.size.width / 2)
//            }
            VStack {
                
                ZStack {
                    
                    GridView(yCount: vj.yCount,
                             tapOnCircles: $tapOnSmallCircles, hint: false)
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .border(Color.primary)
                    
                    GridView(yCount: vj.yCount - 2,
                             tapOnCircles: $tapOnBigCircles, hint: false)
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .border(Color.primary)
                    .blendMode(.difference)
                    
                }
                .aspectRatio(16 / 9, contentMode: .fit)
                
            
                HStack {
                 
                    GridView(yCount: vj.yCount,
                             tapOnCircles: $tapOnSmallCircles, hint: true)
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .border(Color.primary)
                    
                    GridView(yCount: vj.yCount - 2,
                             tapOnCircles: $tapOnBigCircles, hint: true)
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .border(Color.primary)
                    
                }
                
                HStack {
                    Stepper("Y Count", value: $vj.yCount)
                        .frame(width: 170)
                }
                .padding()
                
            }
            
//            InteractView { tap in
//                vj.tap = tap
//            }
            
        }
            .opacity(vj.opacity)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: { () -> CGFloat? in
                #if os(macOS)
                return 1920 * 0.25
                #else
                return nil
                #endif
            }(), height: { () -> CGFloat? in
                #if os(macOS)
                return 1080 * 0.25
                #else
                return nil
                #endif
            }())
            .environmentObject(VJModel())
    }
}
