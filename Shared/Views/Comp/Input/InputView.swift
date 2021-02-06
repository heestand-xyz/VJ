//
//  InputView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI
import MultiViews

struct InputView: View {
    
    @ObservedObject var vj: VideoJockey
    
    var body: some View {
        
        VStack {
        
            HStack {
                    
                PreCompView(vj: vj, compSpot: .topLeft)
                
                Divider()
                
                PreCompView(vj: vj, compSpot: .topRight)
                
            }
            
            Divider()
            
            HStack {
                    
                PreCompView(vj: vj, compSpot: .bottomLeft)
                
                Divider()
                
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
