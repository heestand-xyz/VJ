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
    
    @State var tapOnCircleA: Bool = false
    @State var tapOnCircleB: Bool = false
    
    var body: some View {
        
        ZStack {
            
//            // Gradient Radial
//            GeometryReader { geo in
//                RadialGradient(gradient: Gradient(colors: [Color.clear, Color.primary]), center: .center, startRadius: 0.0, endRadius: geo.size.width / 2)
//            }
            
            VStack {
                CircleView(on: $tapOnCircleA)
                    .onInteract(on: $tapOnCircleA)
                CircleView(on: $tapOnCircleB)
                    .onInteract(on: $tapOnCircleB)
            }
            
//            InteractView { tap in
//                vj.tap = tap
//            }
            
        }
            .opacity(vj.opacity)
            .padding()
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
