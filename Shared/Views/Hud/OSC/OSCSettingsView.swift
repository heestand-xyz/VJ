//
//  OSCSettingsView.swift
//  VJ
//
//  Created by Cappuccino on 2020-09-01.
//

import SwiftUI
import MultiplatformTypes

struct OSCSettingsView: View {
    
    @ObservedObject var osc: OSC
    @ObservedObject var settings: Settings
    @ObservedObject var connection: Connection
    
    @State var showSettings: Bool = false
    
    var body: some View {
        
        HStack {
            
            Text("OSC")
            
            Button {
                Connection.main.monitor()
                Connection.main.check()
            } label: {
                Label("Ping", systemImage: "wifi")
            }
            
            Button {
                showSettings = true
            } label: {
                Label("Settings", systemImage: "gear")
            }
            
        }
        .mono()
        .sheet(isPresented: $showSettings) {
            OSCSettingsPopupView(osc: osc, settings: settings, connection: connection)
        }
        
    }
    
}

struct OSCSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        OSCSettingsView(osc: OSC.main,
                        settings: Settings.main,
                        connection: Connection.main)
    }
}
