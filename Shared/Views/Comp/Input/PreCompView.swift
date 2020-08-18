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
        
        return VStack(spacing: 0.0) {
            
            if compSpot.isTop {
                CompSettingsView(comp: comp)
            }
            
            CompView(vj: vj, comp: comp, hint: true)
            
            if compSpot.isBottom {
                CompSettingsView(comp: comp)
            }
            
        }
        
//        return HStack(spacing: 0.0) {
//
//            if compSpot.isLeft {
//                CompSettingsView(comp: comp)
//            }
//
//            CompView(vj: vj, comp: comp, hint: true)
//
//            if compSpot.isRight {
//                CompSettingsView(comp: comp)
//            }
//
//        }
        
    }
    
}

struct PreCompView_Previews: PreviewProvider {
    static var previews: some View {
        PreCompView(vj: VideoJockey(), compSpot: .topLeft)
    }
}
