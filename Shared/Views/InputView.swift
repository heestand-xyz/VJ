//
//  InputView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI
import MultiplatformTypes

struct InputView: View {
    
    @EnvironmentObject var vj: VideoJockey
    
    var body: some View {
        
        VStack(spacing: 0.0) {
        
            HStack(spacing: 0.0) {
                    
                CompView(comp: vj.comps[.topLeft]!)
                
                CompView(comp: vj.comps[.topRight]!)
                
            }
            
            HStack(spacing: 0.0) {
                    
                CompView(comp: vj.comps[.bottomLeft]!)
                
                CompView(comp: vj.comps[.bottomRight]!)
                
            }
            
        }
        
    }
    
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
            .environmentObject(VideoJockey())
    }
}
