//
//  VJ.swift
//  VJ
//
//  Created by Hexagons with Cappuccino on 2020-08-12.
//
//  Noise is just distant reflected sounds.
//

import Foundation
import CoreGraphics
#if canImport(AirKit)
import AirKit
#endif

class VideoJockey: ObservableObject {
    
    @Published var opacity: Double = 1.0
    
    @Published var spacing: CGFloat = 0.0
    
    // MARK: - Comps
    
    var comps: [Comp.Spot: Comp] = [:]
    
    // MARK: - Count
    
    static let vCountMax: Int = 3
    
    // MARK: - Other
    
    @Published var flash: Bool = false
    
    #if canImport(AirKit)
    @Published var isAirPlaying: Bool = false
    #endif
    
    @Published var tap: Bool = false
    
    // MARK: - Life Cycle
    
    init() {
        
        for compSpot in Comp.Spot.allCases {
            comps[compSpot] = Comp()
        }
        
        #if canImport(AirKit)
        Air.connection { connected in
            self.isAirPlaying = connected
        }
        #endif
        
    }
    
}
