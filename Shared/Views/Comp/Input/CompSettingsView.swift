//
//  CompSettingsView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI

struct CompSettingsView: View {
    
     @ObservedObject var comp: Comp
     
    var body: some View {
        
        VStack {

            // V Count
            Stepper("", value: $comp.vCount, in: 0...VideoJockey.vCountMax)
                .frame(width: 100)
                .offset(x: -4)

        }
        
    }
    
}

struct CompSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CompSettingsView(comp: Comp())
    }
}
