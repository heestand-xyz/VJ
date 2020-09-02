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
import MultiplatformTypes
import Trails

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var vj: VideoJockey
    
    var body: some View {
        
        VStack {
            
            OSCInfoView(osc: OSC.main,
                        settings: Settings.main,
                        connection: Connection.main)
                .frame(maxWidth: 500)
                .offset(y: 5)
            
            GeometryReader { geo in
                    
                HStack(spacing: 0.0) {
                    
                    // Status
                    VStack {
                        HStack {
                            StatusView(vj: vj)
                            Spacer()
                        }
                        OSCSettingsView(vj: vj,
                                        osc: OSC.main,
                                        settings: Settings.main,
                                        connection: Connection.main)
                        TrailsView(trailer: vj.trailer)
                        Spacer()
                    }
                    .frame(width: max(200, (geo.size.width - (geo.size.height * VideoJockey.aspectRatio)) / 2))
                    
                    // Preview of Final Output
                    if vj.preview {
                        ZStack {
                            FinalView(vj: vj)
                            InteractView { interacted in
                                vj.flash = interacted
                            }
                        }
                        .border(vj.showBorder ? Color.primary : Color.clear)
                    } else {
                        Spacer()
                    }

                    // Settings
                    VStack {
                        SettingsView(vj: vj)
                        Spacer()
                    }
                    .frame(width: max(200, (geo.size.width - (geo.size.height * VideoJockey.aspectRatio)) / 2))
                    
                }
                
            }
            
            Divider()
            
            // Input Content
            InputView(vj: vj)
            
        }
        .ignoresSafeArea(edges: .top)

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
