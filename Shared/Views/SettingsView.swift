//
//  SettingsView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var vj: VideoJockey
    
    var body: some View {
        
        VStack(spacing: 20) {
        
            // Header
            HStack {
                
                Group {
                    
                    Image("VJ")
                        .resizable()
                        .renderingMode(.template)
                    
                    Image("Hexagons")
                        .resizable()
                    
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75)
                
                Spacer()
                
                #if canImport(AirKit)
                if vj.isAirPlaying {
                    Image(systemName: "airplayvideo")
                        .font(.system(size: 25, weight: .bold, design: .default))
                } else {
                    Text("No HDMI")
                        .font(.caption)
                }
                #endif
                
            }
            
            // Opacity
            HStack(spacing: 20) {
            
                Button {
                    vj.opacity = 0.0
                } label: {
                    Image(systemName: "sun.min" + (vj.opacity == 0.0 ? "" : ".fill"))
                }
                .disabled(vj.opacity == 0.0)
                
                Slider(value: $vj.opacity)
                
                Button {
                    vj.opacity = 1.0
                } label: {
                    Image(systemName: "sun.max" + (vj.opacity == 1.0 ? "" : ".fill"))
                }
                .disabled(vj.opacity == 1.0)
                
            }
            .font(.system(size: 30))
            
            Spacer()
            
        }
        .frame(width: 250)
        .padding()
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(vj: VideoJockey())
    }
}
