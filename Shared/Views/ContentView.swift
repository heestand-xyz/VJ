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
import MultiViews
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
            
            Divider()
            
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
                    .frame(width: 350)
//                    .frame(width: max(300, (geo.size.width - (geo.size.height * vj.aspectRatio)) / 2))
                    
                    Divider()
                    Spacer()
                    Divider()

                    // Final Preview
                    if vj.preview {
                        
                        ZStack {
                            FinalView(vj: vj)
                            MVInteractView { interacted in
                                vj.mainTouch = interacted == .started
                            }
                        }
                        .aspectRatio(vj.aspectRatio, contentMode: .fit)
                        
                    } else {
                        Spacer()
                    }
                    
                    Divider()
                    Spacer()
                    Divider()

                    // Settings
                    VStack {
                        SettingsView(vj: vj)
                        Spacer()
                    }
                    .frame(width: 350)
//                    .frame(width: max(300, (geo.size.width - (geo.size.height * vj.aspectRatio)) / 2))
                    
                }
                
            }
            
            Divider()
            
            // Input Content
            InputView(vj: vj)
                .frame(height: 600)
            
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
