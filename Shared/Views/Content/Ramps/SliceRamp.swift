//
//  SliceRamp.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-18.
//

import SwiftUI

struct SliceRamp: View {
    
    var body: some View {
        
        HStack(spacing: 0.0) {
            
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.white]), startPoint: .bottom, endPoint: .top)
            
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.white]), startPoint: .top, endPoint: .bottom)
            
        }
        
    }
    
}

struct SliceRamp_Previews: PreviewProvider {
    static var previews: some View {
        SliceRamp()
    }
}
