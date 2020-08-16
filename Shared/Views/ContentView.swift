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
    
    @EnvironmentObject var vj: VideoJockey
    
    var body: some View {
        
        VStack {
            
//            // Gradient Radial
//            GeometryReader { geo in
//                RadialGradient(gradient: Gradient(colors: [Color.clear, Color.primary]), center: .center, startRadius: 0.0, endRadius: geo.size.width / 2)
//            }
            
            HStack {
                
                Spacer()
                
                // Settings
                SettingsView()
                
                Spacer()
                
                // Output on Air
                OutputView()
                
            }
            
            // Input on iPad
            InputView()
            
        }

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
            .environmentObject(VideoJockey())
    }
}
