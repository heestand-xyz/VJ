//
//  ContentView.swift
//  Shared
//
//  Created by Cappuccino on 2020-08-12.
//

import SwiftUI
#if canImport(AirKit)
import AirKit
#endif

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var vj: VideoJockey
    
    var body: some View {
        
        VStack {
            
//            // Gradient Radial
//            GeometryReader { geo in
//                RadialGradient(gradient: Gradient(colors: [Color.clear, Color.primary]), center: .center, startRadius: 0.0, endRadius: geo.size.width / 2)
//            }
            
            HStack {
                
                // Settings
                VStack {
                    
                    SettingsView(vj: vj)
                    
                    Spacer()
                    
                }
                
                Spacer()
                
                // Output on Air
                OutputView(vj: vj)
                    .air()
                    .border(Color.primary)
                    .hide(!vj.preview)
                
            }
            
            // Input on iPad
            InputView(vj: vj)
            
        }

    }
    
}

extension View {
    func air() -> some View {
        #if canImport(AirKit)
        return self.airPlay()
        #else
        return self
        #endif
    }
}

extension View {
    func hide(_ hidden: Bool) -> some View {
        Group {
            if hidden {
                self.hidden()
                    .frame(width: 0, height: 0)
            } else {
                self
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vj: VideoJockey())
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
    }
}
