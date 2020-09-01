//
//  OSCInfoView.swift
//  Clean OSC 2
//
//  Created by Anton Heestand on 2019-11-25.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import SwiftUI

struct OSCInfoView: View {
    @ObservedObject var osc: OSC
    @ObservedObject var settings: Settings
    @ObservedObject var connection: Connection
    var body: some View {
        HStack(spacing: 4) {
            
//            Text(self.settings.clientAddress)
//                .lineLimit(1)
//            Text(":" + String(describing: self.settings.clientPort))
//                .foregroundColor(.gray)

//            Spacer(minLength: 0)
            
            Image(systemName: "radiowaves.left")
                .foregroundColor(self.osc.resentOutput ? .blue : .gray)
            Text("OSC")
            Image(systemName: "radiowaves.right")
                .foregroundColor(self.osc.resentInput ? .blue : .gray)
            
            Spacer(minLength: 0)
                .frame(width: 10) // fixed padding
            
            Image(systemName: self.connection.wifi == true ? "wifi" : "wifi.slash")
                .foregroundColor(self.connection.wifi == true ? .blue : .gray)
                .offset(y: self.connection.wifi == true ? 0 : -2)
            Text(self.connection.ipAddress ?? "#.#.#.#")
                .lineLimit(1)
            Text(":" + String(describing: self.settings.serverPort))
                .foregroundColor(self.osc.serverStarted ? .gray : .red)
            
        }
        .font(.system(size: 12, weight: .regular, design: .monospaced))
        .padding(.horizontal)
        .frame(height: 20)
    }
}

struct OSCInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OSCInfoView(osc: OSC.main,
                    settings: Settings.main,
                    connection: Connection.main)
    }
}
