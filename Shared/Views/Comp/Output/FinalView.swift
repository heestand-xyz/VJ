//
//  FinalView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-21.
//

import SwiftUI

struct FinalView: View {
    
    @ObservedObject var vj: VideoJockey
    
    var output: some View { OutputView(vj: vj) }
    
    var body: some View {
        
        ZStack {
            
            ZStack {
                Color.red
                output
                    .compositingGroup()
                    .blendMode(.multiply)
            }
            .compositingGroup()
            .offset(x: -vj.colorShift)
            
            ZStack {
                Color.green
                output
                    .compositingGroup()
                    .blendMode(.multiply)
            }
            .compositingGroup()
            .blendMode(.screen)
            
            ZStack {
                Color.blue
                output
                    .compositingGroup()
                    .blendMode(.multiply)
            }
            .compositingGroup()
            .blendMode(.screen)
            .offset(x: vj.colorShift)
            
        }
        
    }
    
}

struct FinalView_Previews: PreviewProvider {
    static var previews: some View {
        FinalView(vj: VideoJockey())
    }
}
