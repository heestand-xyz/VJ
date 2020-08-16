//
//  PreCompView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI

struct PreCompView: View {
   
    @ObservedObject var vj: VideoJockey
    let compSpot: Comp.Spot
    
    var body: some View {
        
        let comp: Comp = vj.comps[compSpot]!
        
        return HStack {
            
            if compSpot.isLeft {
                CompSettingsView(comp: comp)
            }
            
            CompView(vj: vj, comp: comp, hint: true)
            
            if compSpot.isRight {
                CompSettingsView(comp: comp)
            }
            
        }
        
    }
    
}

struct PreCompView_Previews: PreviewProvider {
    static var previews: some View {
        PreCompView(vj: VideoJockey(), compSpot: .topLeft)
    }
}
