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
import Trails

class VideoJockey: ObservableObject {
    
    // MARK: - OSC
    
    let trailer: Trailer
    
    @Published var oscAddress: String?
    @Published var oscValue: CGFloat? {
        didSet {
            trailer.add(Double(oscValue ?? -1), at: 0)
        }
    }
//    @Published var oscValueAsString: String?

    // MARK: - Settings
    
    @Published var opacity: Double = 1.0
    
//    @Published var spacing: CGFloat = 0.0
    
    @Published var preview: Bool = true
    
    @Published var test: Bool = false
    
    @Published var colorShift: CGFloat = 1.0
    
    let showBorder: Bool = false
    
    // MARK: - Comps
    
    var comps: [Comp.Spot: Comp] = [:]
    
    // MARK: - Count
    
    static let vCountMax: Int = 2
    static let vCountDefault: Int = 1
    
    // MARK: - Other
    
    @Published var flash: Bool = false
    
    #if canImport(AirKit)
    @Published var isAirPlaying: Bool = false
    #endif
    
//    @Published var tap: Bool = false
    
    // MARK: - OSC
    
//    let oscIn: OSCIn
//    let oscOut: OSCOut
    
    // MARK: - Life Cycle
    
    init() {
        
        trailer = Trailer(count: 1, duration: 1.0)
        
        Connection.main.monitor()
        Connection.main.check()
        
        OSC.main.startListen()
        OSC.main.messageCallback = gotOSC
        
        // Global Blur
        
//        oscIn = OSCIn()
//        oscOut = OSCOut()
//        oscOut.send()
        
        for compSpot in Comp.Spot.allCases {
            switch compSpot {
            case .topLeft:
                comps[compSpot] = Comp(vCount: 1, gridShape: .hexagons, corner: 0.0)
            case .topRight:
                comps[compSpot] = Comp(vCount: 1, gridShape: .hexagons, corner: 1.0)
            case .bottomLeft:
                comps[compSpot] = Comp(vCount: 0, gridShape: .hexagons, corner: 0.0)
            case .bottomRight:
                comps[compSpot] = Comp(vCount: 0, gridShape: .hexagons, corner: 1.0)
            }
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

        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIScene.willEnterForegroundNotification, object: nil)

    }
    
    @objc func appWillEnterForeground() {
        Connection.main.monitor()
        Connection.main.check()
        oscAddress = nil
        oscValue = nil
//        oscValueAsString = nil
    }
    
    // MARK: - Present
    
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
    
    // MARK: - OSC
    
    func gotOSC(_ address: String, _ value: Any) {
        print("OSC at \"\(address)\":", value)
        guard address == "beats" else { return }
        oscAddress = address
        if let val: Int = value as? Int {
            oscValue = CGFloat(val) / 127
        } else if let val: CGFloat = value as? CGFloat {
            oscValue = val
        } else if let val: [CGFloat] = value as? [CGFloat] {
            oscValue = val.first
        } else {
            oscValue = nil
        }
//        oscValueAsString = String(describing: value)
    }
    
}
