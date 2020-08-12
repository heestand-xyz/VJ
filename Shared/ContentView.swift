//
//  ContentView.swift
//  Shared
//
//  Created by Cappuccino on 2020-08-12.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vj: VJModel
    var body: some View {
        Circle()
            .onTapGesture {
                vj.opacity = 0.0
                withAnimation {
                    vj.opacity = 1.0
                }
            }
            .opacity(vj.opacity)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(VJModel())
    }
}
