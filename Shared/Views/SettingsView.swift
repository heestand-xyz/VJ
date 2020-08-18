//
//  SettingsView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI
import MultiplatformTypes

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
                Group {
                    if vj.isAirPlaying {
                        Label("HDMI", systemImage: "airplayvideo")
                    } else {
                        Text("No HDMI")
                            .opacity(0.5)
                    }
                }
                .mono()
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
            .buttonStyle(PlainButtonStyle())
            .font(.system(size: 30))
            .bg()
            
            HStack {
                
                ToggleText(title: "Test", isOn: $vj.test)
                
                ToggleText(title: "Preview", isOn: $vj.preview)
                
                Spacer()
                
            }
            
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
