//
//  CompView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI

struct CompView: View {
    
    @ObservedObject var vj: VideoJockey
    @ObservedObject var comp: Comp
    var hint: Bool = false
    
    var body: some View {
        
        ZStack {
            
            ForEach(0..<(VideoJockey.vCountMax + 1)) { v in
                
                if comp.vCount == v {
                    
                    //                    ForEach(Comp.GridShape.allCases) { gridShape in
                    
                    switch comp.gridShape {
                    case .squareCircles:
                        
                        GridView(yCount: 1 + v * 2,
                                 grid: Binding<[Bool]>(get: {
                                    comp.grids[.squareCircles]![v]!
                                 }, set: { values in
                                    comp.grids[.squareCircles]![v]! = values
                                 }), hint: hint)
                        
                    case .hexagons:
                        
                        HexGridView(yCount: 1 + v * 2,
                                    relativeCornerRadius: vj.relativeCornerRadius,
                                    grid: Binding<[Bool]>(get: {
                                        comp.grids[.hexagons]![v]!
                                    }, set: { values in
                                        comp.grids[.hexagons]![v]! = values
                                    }), hint: hint)
                        
                    case .hexagonsCircles:
                        
                        HexGridView(yCount: 1 + v * 2,
                                    relativeCornerRadius: vj.relativeCornerRadius,
                                    asCircle: true,
                                    grid: Binding<[Bool]>(get: {
                                        comp.grids[.hexagonsCircles]![v]!
                                    }, set: { values in
                                        comp.grids[.hexagonsCircles]![v]! = values
                                    }), hint: hint)
                        
                    }
                    
                    
                }
                
            }
        
        }
        .aspectRatio(16 / 9, contentMode: .fit)
        .border(Color.primary)
        .clipped()
        
    }
    
}

struct CompView_Previews: PreviewProvider {
    static var previews: some View {
        let vj = VideoJockey()
        return CompView(vj: vj, comp: vj.comps[.topLeft]!)
    }
}
