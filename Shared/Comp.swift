//
//  Comp.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import Foundation
import CoreGraphics

class Comp: ObservableObject {
    
    // Relative Corner Radius for Hexagons
    @Published var corner: CGFloat
    
    enum Spot: Int, Identifiable, CaseIterable {
        var id: Int { rawValue }
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        var isLeft: Bool {
            [.topLeft, .bottomLeft].contains(self)
        }
        var isRight: Bool {
            [.topRight, .bottomRight].contains(self)
        }
        var isTop: Bool {
            [.topLeft, .topRight].contains(self)
        }
        var isBottom: Bool {
            [.bottomLeft, .bottomRight].contains(self)
        }
    }

    @Published var vCount: Int
    var yCount: Int { 1 + vCount * 2 }
    
    // MARK: - Grids
    
    enum GridShape: Int, Identifiable, CaseIterable {
        var id: Int { rawValue }
        case squareCircles
        case hexagons
        case hexagonsCircles
        var systemName: String {
            switch self {
            case .squareCircles: return "circle.grid.3x3.fill"
            case .hexagons: return "hexagon.fill"
            case .hexagonsCircles: return "circles.hexagongrid.fill"
            }
        }
    }
    @Published var gridShape: GridShape
    
    @Published var grids: [GridShape: [Int: [Bool]]] = [:]
    
    // MARK: - Life Cycle
    
    init(vCount: Int = VideoJockey.vCountDefault, gridShape: GridShape = .hexagons, corner: CGFloat = 0.0) {
        precondition(vCount >= 0)
        precondition(vCount <= VideoJockey.vCountMax)
        
        self.vCount = vCount
        self.gridShape = gridShape
        self.corner = corner
        
        for gridShape in GridShape.allCases {
            var subGrids: [Int: [Bool]] = [:]
            for v in 0...VideoJockey.vCountMax {
                subGrids[v] = []
            }
            grids[gridShape] = subGrids
        }
        
    }
    
}
