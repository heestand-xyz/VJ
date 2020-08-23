//
//  VJ.swift
//  VJ
//
//  Created by Hexagons with Cappuccino on 2020-08-12.
//
//  Noise is just distant reflections.
//

import Foundation
import CoreGraphics
#if canImport(AirKit)
import AirKit
#endif
import SwiftUI
#if canImport(AppKit)
import AppKit
#endif
import MultiplatformTypes

class VideoJockey: ObservableObject {
    
    // MARK: - Settings
    
    @Published var opacity: Double = 1.0
    
//    @Published var spacing: CGFloat = 0.0
    
    @Published var preview: Bool = true
    
    @Published var test: Bool = false
    
    @Published var colorShift: CGFloat = 1.0
    
    // MARK: - Comps
    
    var comps: [Comp.Spot: Comp] = [:]
    
    // MARK: - Count
    
    static let vCountMax: Int = 2
    
    // MARK: - Other
    
    @Published var flash: Bool = false
    
    #if canImport(AirKit)
    @Published var isAirPlaying: Bool = false
    #endif
    
//    @Published var tap: Bool = false
    
    // MARK: - OSC
    
    let oscIn: OSCIn
    let oscOut: OSCOut
    
    // MARK: - Life Cycle
    
    init() {
        
        // Global Blur
        
        oscIn = OSCIn()
        oscOut = OSCOut()
        oscOut.send()
        
        for compSpot in Comp.Spot.allCases {
            comps[compSpot] = Comp()
        }
        
        #if canImport(AirKit)
        Air.play(AnyView(FinalView(vj: self)))
        Air.connection { connected in
            self.isAirPlaying = connected
        }
        #endif
        
        #if os(macOS)
        DispatchQueue.main.async {
            self.present()
        }
        #endif
        
    }
    
    #if os(macOS)
    func present() {
        let window: NSWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 100, height: 100),
                                        styleMask: [.titled, .miniaturizable, .fullSizeContentView, .resizable],
                                        backing: .buffered, defer: false)
        window.contentView = NSHostingView(rootView:
                                            ZStack {
                                                Color.black
                                                FinalView(vj: self)
                                            })
        window.makeKeyAndOrderFront(nil)
    }
    #endif
    
}
