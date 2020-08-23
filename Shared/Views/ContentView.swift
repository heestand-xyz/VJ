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

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var vj: VideoJockey
    
    var body: some View {
        
        VStack {
            
            GeometryReader { geo in
                    
                HStack(spacing: 0.0) {
                    
                    // Status
                    VStack {
                        HStack {
                            StatusView(vj: vj)
                            Spacer()
                        }
                        Spacer()
                    }
                    .frame(width: (geo.size.width - (geo.size.height * (16 / 9))) / 2)
                    
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
                    .frame(width: (geo.size.width - (geo.size.height * (16 / 9))) / 2)
                    
                }
                
            }
            
            Divider()
            
            // Input Content
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
