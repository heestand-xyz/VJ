//
//  CompView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI

struct CompView: View {
    
    @EnvironmentObject var vj: VideoJockey
    @ObservedObject var comp: Comp
    
    var body: some View {
        
        HStack {
            
            // V Count A
            Stepper("", value: $comp.vCount, in: 0...VideoJockey.vCountMax)
                .frame(width: 100)
                .offset(x: -4)
            
            // Grid A
            ZStack {
                
                ForEach(0..<(VideoJockey.vCountMax + 1)) { v in
                    if comp.vCount == v {
                        HexGridView(yCount: 1 + v * 2,
                                    relativeCornerRadius: vj.relativeCornerRadius,
                                    grid: Binding<[Bool]>(get: {
                                        comp.grids[.hexagons]![v]!
                                    }, set: { values in
                                        comp.grids[.hexagons]![v]! = values
                                    }), hint: true)
                    }
                }
                
            }
            .aspectRatio(16 / 9, contentMode: .fit)
            .border(Color.primary)
            .clipped()
            
        }
        
    }
    
}

struct CompView_Previews: PreviewProvider {
    static var previews: some View {
        let vj = VideoJockey()
        return CompView(comp: vj.comps[.topLeft]!)
            .environmentObject(vj)
    }
}
