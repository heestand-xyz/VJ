//
//  ContentView.swift
//  Shared
//
//  Created by Cappuccino on 2020-08-12.
//

import SwiftUI
import AirKit

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
                
                Spacer()
                
                // Settings
                SettingsView(vj: vj)
                
                Spacer()
                
                // Output on Air
                OutputView(vj: vj)
                
            }
            
            // Input on iPad
            InputView(vj: vj)
            
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
