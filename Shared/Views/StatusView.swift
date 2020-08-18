//
//  StatusView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI
import MultiplatformTypes

struct StatusView: View {
    
    @ObservedObject var vj: VideoJockey
    
    var body: some View {
        
        HStack {
            
            Group {
                
                Image("Hexagons")
                    .resizable()
                
                Image("VJ")
                    .resizable()
                    .renderingMode(.template)
                
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 75, height: 75)
            
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
        
    }
    
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(vj: VideoJockey())
    }
}
