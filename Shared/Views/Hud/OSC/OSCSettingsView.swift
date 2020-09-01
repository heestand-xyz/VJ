//
//  OSCSettingsView.swift
//  VJ
//
//  Created by Cappuccino on 2020-09-01.
//

import SwiftUI
import MultiplatformTypes

struct OSCSettingsView: View {
    
    @ObservedObject var vj: VideoJockey
    
    @ObservedObject var osc: OSC
    @ObservedObject var settings: Settings
    @ObservedObject var connection: Connection
    
    @State var showSettings: Bool = false
    
    var body: some View {
        
        VStack {
            
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
            
            VStack {
                Text(vj.oscAddress ?? "No OSC")
//                Text(vj.oscValueAsString ?? "No Value")
                Slider(value: Binding<CGFloat>(get: {
                    vj.oscValue ?? 0.0
                }, set: { value in
                    vj.oscValue = value
                }))
                    .disabled(vj.oscValue == nil)
            }
            .padding()
            
        }
        .mono()
        .sheet(isPresented: $showSettings) {
            OSCSettingsPopupView(osc: osc, settings: settings, connection: connection)
        }
        
    }
    
}

struct OSCSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        OSCSettingsView(vj: VideoJockey(),
                        osc: OSC.main,
                        settings: Settings.main,
                        connection: Connection.main)
    }
}
