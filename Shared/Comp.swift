//
//  Comp.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import Foundation

class Comp: ObservableObject {
    
    enum Spot: Int, Identifiable, CaseIterable {
        var id: Int { rawValue }
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }

    @Published var vCount: Int = 2
    var yCount: Int { 1 + vCount * 2 }
    
    // MARK: - Grids
    
    enum GridShape: CaseIterable {
        case squareCircles
        case hexagons
        case hexagonsCircles
    }
    @Published var grids: [GridShape: [Int: [Bool]]] = [:]
    
    // MARK: - Life Cycle
    
    init() {
        
        for gridShape in GridShape.allCases {
            var subGrids: [Int: [Bool]] = [:]
            for v in 0...VideoJockey.vCountMax {
                subGrids[v] = []
            }
            grids[gridShape] = subGrids
        }
        
    }
    
}
