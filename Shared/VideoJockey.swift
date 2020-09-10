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
    
    // Beats
    @Published var audioBeats: CGFloat = 0.0 {
        didSet {
            trailer.add(Double(audioBeats), at: 0)
            
            onDJ = audioBeats > 1.0 / 3.0
            
        }
    }
    
    // Bass
    @Published var audioBass: CGFloat = 0.0 {
        didSet {
            trailer.add(Double(audioBass), at: 1)
            
            blur = audioBass
            
        }
    }
    
    // Chords
    @Published var audioChords: CGFloat = 0.0 {
        didSet {
            trailer.add(Double(audioChords), at: 2)
            
            colorShift = audioChords
            
        }
    }
    
    // Melody
    @Published var audioMelody: CGFloat = 0.0 {
        didSet {
            trailer.add(Double(audioMelody), at: 3)
            
            colorShift = audioMelody
            
        }
    }
    
    @Published var onDJ: Bool = false

    // MARK: - Settings
    
    @Published var opacity: Double = 1.0
    
//    @Published var spacing: CGFloat = 0.0
    
    @Published var preview: Bool = true
    
    @Published var test: Bool = false
    @Published var tag: Bool = false

    @Published var colorShift: CGFloat = 0.0
    @Published var colorWheel: Double = 0.0

    // MARK: - Comps
    
    var comps: [Comp.Spot: Comp] = [:]
    
    // MARK: - Count
    
    static let vCountMax: Int = 2
    static let vCountDefault: Int = 1
    
    // MARK: - Other
    
    // currently not in use
    @Published var mainTouch: Bool = false
    
    @Published var blur: CGFloat = 0.0

    #if canImport(AirKit)
    @Published var isAirPlaying: Bool = false
    #endif
    
//    @Published var tap: Bool = false
    
    // MARK: - OSC
    
//    let oscIn: OSCIn
//    let oscOut: OSCOut
    
    @Published var aspectRatio: CGFloat = 16 / 10
    
    @Published var padding: CGFloat = 0.0
    
    // MARK: - Life Cycle
    
    init() {
        
        trailer = Trailer(count: 4, duration: 3.0)
//        trailer.circlesActive = true
//        trailer.circleBorder = false
//        trailer.circleRadius = 2
        trailer.fixedMin = 0.0
        trailer.fixedMax = 1.0
        
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
//                comps[compSpot] = Comp(vCount: 1, gridShape: .hexagons, corner: 1.0)
                comps[compSpot] = Comp(vCount: 1, gridShape: .hexagonsCircles)
            case .bottomLeft:
                comps[compSpot] = Comp(vCount: 0, gridShape: .hexagons, corner: 0.0)
            case .bottomRight:
//                comps[compSpot] = Comp(vCount: 0, gridShape: .hexagons, corner: 1.0)
                comps[compSpot] = Comp(vCount: 0, gridShape: .hexagonsCircles)
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
        audioBeats = 0.0
        audioBass = 0.0
        audioChords = 0.0
        audioMelody = 0.0
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
        func val() -> CGFloat {
            if let val: Int = value as? Int {
                return CGFloat(val) / 127
            } else if let val: CGFloat = value as? CGFloat {
                return val
            } else if let val: [CGFloat] = value as? [CGFloat] {
                return val.first ?? 0.0
            } else {
                return 0.0
            }
        }
        switch address {
        case "beats":
            audioBeats = val()
        case "bass":
            audioBass = val()
        case "chords":
            audioChords = val()
        case "melody":
            audioMelody = val()
        default:
            break
        }
    }
    
}
