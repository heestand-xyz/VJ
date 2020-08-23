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
    
    var comp: Comp { vj.comps[compSpot]! }
    
    var body: some View {
        
        HStack(spacing: 0.0) {

            if compSpot.isLeft {
                CompSettingsView(comp: comp)
                Divider()
            }

            CompView(vj: vj, comp: comp, hint: true)

            if compSpot.isRight {
                Divider()
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
