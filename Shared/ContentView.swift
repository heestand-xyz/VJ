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
    
    var body: some View {
        
        ZStack {
            
            // Gradient Radial
            GeometryReader { geo in
                RadialGradient(gradient: Gradient(colors: [Color.clear, Color.primary]), center: .center, startRadius: 0.0, endRadius: geo.size.width / 2)
            }
            
            // Circle
            ZStack {
                let width: CGFloat = 10
                Circle()
                    .foregroundColor(vj.tap ? .primary : .clear)
                    .padding(width)
                Circle()
                    .strokeBorder(lineWidth: width)
                    .foregroundColor(vj.tap ? .clear : .primary)
            }
            
            InteractView { tap in
                vj.tap = tap
            }
            
        }
            .opacity(vj.opacity)
            .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 1920 * 0.25,
                   height: 1080 * 0.25)
            .environmentObject(VJModel())
    }
}
