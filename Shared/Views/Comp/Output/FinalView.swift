//
//  FinalView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-21.
//

import SwiftUI

struct FinalView: View {
    
    @ObservedObject var vj: VideoJockey
    
    var output: some View {
        OutputView(vj: vj)
            .compositingGroup()
            .blendMode(.multiply)
    }
    
    var body: some View {
        
        ZStack {
            
            Color.black
            
            Group {
                
                ZStack {
                    Color.red
                    output
                }
                .offset(x: -vj.colorShift)
                
                ZStack {
                    Color.green
                    output
                }
                
                ZStack {
                    Color.blue
                    output
                }
                .offset(x: vj.colorShift)
                
            }
            .compositingGroup()
            .blendMode(.plusLighter)
            
        }
        
    }
    
}

struct FinalView_Previews: PreviewProvider {
    static var previews: some View {
        FinalView(vj: VideoJockey())
    }
}
