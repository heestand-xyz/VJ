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
                Spacer()
                CompSettingsView(comp: comp)
                Spacer()
            }
            
            CompView(vj: vj, comp: comp, hint: true)
            
            if compSpot.isRight {
                Spacer()
                CompSettingsView(comp: comp)
                Spacer()
            }
            
        }
        
    }
    
}

struct PreCompView_Previews: PreviewProvider {
    static var previews: some View {
        PreCompView(vj: VideoJockey(), compSpot: .topLeft)
    }
}
