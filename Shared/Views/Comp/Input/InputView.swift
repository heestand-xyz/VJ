//
//  InputView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI
import MultiplatformTypes

struct InputView: View {
    
    @ObservedObject var vj: VideoJockey
    
    var body: some View {
        
        VStack(spacing: 0.0) {
        
            HStack(spacing: 0.0) {
                    
                PreCompView(vj: vj, compSpot: .topLeft)
                
                PreCompView(vj: vj, compSpot: .topRight)
                
            }
            
            HStack(spacing: 0.0) {
                    
                PreCompView(vj: vj, compSpot: .bottomLeft)
                
                PreCompView(vj: vj, compSpot: .bottomRight)
                
            }
            
        }
        
    }
    
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(vj: VideoJockey())
    }
}
