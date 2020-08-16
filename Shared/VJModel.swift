//
//  VJ.swift
//  VJ
//
//  Created by Hexagons with Cappuccino on 2020-08-12.
//
//  Noise is just distant reflected sounds.
//

import Foundation
import AirKit

class VJModel: ObservableObject {
    
    @Published var opacity: Double = 1.0
    
    // MARK: - Count
    
    let vCountMax: Int = 3
    @Published var vCountA: Int = 2
    var yCountA: Int { 1 + vCountA * 2 }
    @Published var vCountB: Int = 1
    var yCountB: Int { 1 + vCountB * 2 }
    
    // MARK: - Grids
    
    @Published var gridCirclesA: [Int: [Bool]] = [:]
    @Published var gridCirclesB: [Int: [Bool]] = [:]
    @Published var gridHexagonsA: [Int: [Bool]] = [:]
    @Published var gridHexagonsB: [Int: [Bool]] = [:]

    // MARK: - Other
    
    @Published var flash: Bool = false
    
    @Published var isAirPlaying: Bool = false
    
    @Published var tap: Bool = false
    
    // MARK: - Life Cycle
    
    init() {
        
        for v in 0...vCountMax {
            gridCirclesA[v] = []
            gridCirclesB[v] = []
            gridHexagonsA[v] = []
            gridHexagonsB[v] = []
        }
        
        Air.connection { connected in
            self.isAirPlaying = connected
        }
        
    }
    
}
