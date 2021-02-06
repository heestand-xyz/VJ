//
//  OSCSettingsView.swift
//  VJ
//
//  Created by Cappuccino on 2020-09-01.
//

import SwiftUI
import MultiViews

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
            
            // OSC Values
            VStack {
                
                // Beats
                HStack {
                    Toggle(isOn: Binding<Bool>(get: {
                        vj.audioBeats > 0.0
                    }, set: { on in
                        vj.audioBeats = on ? 1.0 : 0.0
                    }), label: { EmptyView() })
                    .toggleStyle(SwitchToggleStyle(tint: color(at: 0.0)))
                    .if(iOS, { $0.frame(width: 50).offset(x: -5) })
                    Text("Beats")
                        .frame(width: 65, alignment: .leading)
                        .foregroundColor(color(at: 0.0))
                    Slider(value: $vj.audioBeats)
                        .accentColor(color(at: 0.0))
                }
                
                // Bass
                HStack {
                    Toggle(isOn: Binding<Bool>(get: {
                        vj.audioBass > 0.0
                    }, set: { on in
                        vj.audioBass = on ? 1.0 : 0.0
                    }), label: { EmptyView() })
                    .toggleStyle(SwitchToggleStyle(tint: color(at: 1.0 / 4.0)))
                    .if(iOS, { $0.frame(width: 50).offset(x: -5) })
                    Text("Bass")
                        .frame(width: 65, alignment: .leading)
                        .foregroundColor(color(at: 1.0 / 4.0))
                    Slider(value: $vj.audioBass)
                        .accentColor(color(at: 1.0 / 4.0))
                }
                
                // Chords
                HStack {
                    Toggle(isOn: Binding<Bool>(get: {
                        vj.audioChords > 0.0
                    }, set: { on in
                        vj.audioChords = on ? 1.0 : 0.0
                    }), label: { EmptyView() })
                    .toggleStyle(SwitchToggleStyle(tint: color(at: 2.0 / 4.0)))
                    .if(iOS, { $0.frame(width: 50).offset(x: -5) })
                    Text("Chords")
                        .frame(width: 65, alignment: .leading)
                        .foregroundColor(color(at: 2.0 / 4.0))
                    Slider(value: $vj.audioChords)
                        .accentColor(color(at: 2.0 / 4.0))
                }
                
                // Melody
                HStack {
                    Toggle(isOn: Binding<Bool>(get: {
                        vj.audioMelody > 0.0
                    }, set: { on in
                        vj.audioMelody = on ? 1.0 : 0.0
                    }), label: { EmptyView() })
                    .toggleStyle(SwitchToggleStyle(tint: color(at: 3.0 / 4.0)))
                    .if(iOS, { $0.frame(width: 50).offset(x: -5) })
                    Text("Melody")
                        .frame(width: 65, alignment: .leading)
                        .foregroundColor(color(at: 3.0 / 4.0))
                    Slider(value: $vj.audioMelody)
                        .accentColor(color(at: 3.0 / 4.0))
                }
                
            }
            .padding()
            
        }
        .mono()
        .sheet(isPresented: $showSettings) {
            OSCSettingsPopupView(osc: osc, settings: settings, connection: connection)
        }
        
    }
    
    func color(at hue: Double) -> Color {
        Color(hue: hue, saturation: 2 / 3, brightness: 1.0)
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
