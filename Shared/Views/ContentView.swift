//
//  ContentView.swift
//  Shared
//
//  Created by Cappuccino on 2020-08-12.
//

import SwiftUI
import MultiplatformTypes
import AirKit

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var vj: VJModel
    
    var body: some View {
        
        VStack {
            
//            // Gradient Radial
//            GeometryReader { geo in
//                RadialGradient(gradient: Gradient(colors: [Color.clear, Color.primary]), center: .center, startRadius: 0.0, endRadius: geo.size.width / 2)
//            }
            
            HStack {
                
                Spacer()
                
                // Settings
                VStack(spacing: 20) {
                
                    // Header
                    HStack {
                        
                        Image("VJ")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                        
                        Spacer()
                        
                        Image(systemName: "airplayvideo")
                            .font(.system(size: 25, weight: .bold, design: .default))
                            .foregroundColor(vj.isAirPlaying ? .primary : .clear)
                        
                    }
                    
                    // Opacity
                    HStack(spacing: 20) {
                    
                        Button {
                            vj.opacity = 0.0
                        } label: {
                            Image(systemName: "sun.min.fill")
                        }
                        .disabled(vj.opacity == 0.0)
                        
                        Slider(value: $vj.opacity)
                        
                        Button {
                            vj.opacity = 1.0
                        } label: {
                            Image(systemName: "sun.max.fill")
                        }
                        .disabled(vj.opacity == 1.0)
                        
                    }
                    .font(.system(size: 30))
                    
                    Spacer()
                    
                }
                .frame(width: 250)
                .padding()
                
                Spacer()
                
                // Output on Air
                ZStack {
                    
                    // Grids
                    Group {
                        
                        // A
                        ZStack {
                            ForEach(0..<(vj.vCountMax + 1)) { v in
                                if vj.vCountA == v {
                                    HexGridView(yCount: 1 + v * 2, grid: Binding<[Bool]>(get: {
                                        vj.gridHexagonsA[v]!
                                    }, set: { values in
                                        vj.gridHexagonsA[v]! = values
                                    }))
                                }
                            }
                        }
                        
                        // B
                        ZStack {
                            ForEach(0..<(vj.vCountMax + 1)) { v in
                                if vj.vCountB == v {
                                    HexGridView(yCount: 1 + v * 2, grid: Binding<[Bool]>(get: {
                                        vj.gridHexagonsB[v]!
                                    }, set: { values in
                                        vj.gridHexagonsB[v]! = values
                                    }))
                                }
                            }
                        }
                        .blendMode(.difference)
                        
                    }
                    
                    // Flash
                    Group {
                        if vj.flash {
                            Color.primary
                                .blendMode(.difference)
                        }
                        InteractView { interacted in
                            vj.flash = interacted
                        }
                    }
                    
                }
                .aspectRatio(16 / 9, contentMode: .fit)
                .clipped()
                .opacity(vj.opacity)
                .airPlay()
                .border(Color.primary)
                
            }
            
            // Input on iPad
            HStack(spacing: 0.0) {
                    
                // A
                VStack {
                    
                    // Grid A
                    ZStack {
                        ForEach(0..<(vj.vCountMax + 1)) { v in
                            if vj.vCountA == v {
                                HexGridView(yCount: 1 + v * 2, grid: Binding<[Bool]>(get: {
                                    vj.gridHexagonsA[v]!
                                }, set: { values in
                                    vj.gridHexagonsA[v]! = values
                                }), hint: true)
                            }
                        }
                    }
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .border(Color.primary)
                    .clipped()
                    
                    // V Count A
                    Stepper("", value: $vj.vCountA, in: 0...vj.vCountMax)
                        .frame(width: 100)
                        .offset(x: -4)
                }
                
                // B
                VStack {
                    
                    // Grid V
                    ZStack {
                        ForEach(0..<(vj.vCountMax + 1)) { v in
                            if vj.vCountB == v {
                                HexGridView(yCount: 1 + v * 2, grid: Binding<[Bool]>(get: {
                                    vj.gridHexagonsB[v]!
                                }, set: { values in
                                    vj.gridHexagonsB[v]! = values
                                }), hint: true)
                            }
                        }
                    }
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .border(Color.primary)
                    .clipped()
                    
                    
                    // V Count A
                    Stepper("", value: $vj.vCountB, in: 0...vj.vCountMax)
                        .frame(width: 100)
                        .offset(x: -4)
                }
             
            }
            
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
            .environmentObject(VJModel())
    }
}
