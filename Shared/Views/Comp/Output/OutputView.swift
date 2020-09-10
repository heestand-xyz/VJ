//
//  OutputView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI

struct OutputView: View {
    
    @ObservedObject var vj: VideoJockey
    
    var body: some View {
        
        ZStack {
            
            // Background
            Color.black
            
            // Content
            ZStack {
                
                // Comps
                ForEach(Comp.Spot.allCases) { compSpot in
                    
                    CompView(vj: vj, comp: vj.comps[compSpot]!)
                        .compositingGroup()
                        .blendMode(.difference)
                    
                }
                
                // Test
                if vj.test {
                    TestPattern()
                        .blendMode(.difference)
                }
                
                // Tag
                if vj.tag {
                    TagView()
                        .blendMode(.difference)
                }

                
            }
            .opacity(vj.opacity)
            
        }
        .aspectRatio(vj.aspectRatio, contentMode: .fit)
        .clipped()
        
    }
    
}


struct OutputView_Previews: PreviewProvider {
    static var previews: some View {
        OutputView(vj: VideoJockey())
    }
}
