//
//  OSCSettingsPopupView.swift
//  Clean OSC 2
//
//  Created by Anton Heestand on 2019-11-25.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import SwiftUI

struct OSCSettingsPopupView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var osc: OSC
    @ObservedObject var settings: Settings
    @ObservedObject var connection: Connection
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                HStack(alignment: .top) {
                    Text("OSC")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                    }
                }
                    .padding(.bottom, 25)
                
                VStack(alignment: .leading) {
                    Text("Server Address")
                        .fontWeight(.bold)
                    Text(connection.ipAddress ?? "#.#.#.#")
                        .foregroundColor(.gray)
                        .font(.system(.body, design: .monospaced))
                        .padding(.vertical)
                        .contextMenu(menuItems: {
                            Button(action: {
                                guard let address = self.connection.ipAddress else { return }
                                UIPasteboard.general.string = address
                            }) {
                                Text("Copy")
                            }
                        })
                    Text("Server Port")
                        .fontWeight(.bold)
                    TextField("Port", text: Binding<String>(get: { () -> String in
                        "\(self.settings.serverPort)"
                    }, set: { portText in
                        guard let port = Int(portText) else { return }
                        self.settings.serverPort = port
                        self.osc.updateSettings()
                    }))
                        .foregroundColor(.primary)
                        .padding(5)
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(5)
                }
                
//                Divider()
//
//                VStack(alignment: .leading) {
//                    Text("Client Address")
//                        .fontWeight(.bold)
//                    TextField("Address", text: $settings.clientAddress)
//                        .font(.system(.body, design: .monospaced))
//                        .padding(5)
//                        .background(Color.primary.opacity(0.1))
//                        .cornerRadius(5)
//                    Text("Client Port")
//                        .fontWeight(.bold)
//                    TextField("Port", text: Binding<String>(get: { () -> String in
//                        "\(self.settings.clientPort)"
//                    }, set: { portText in
//                        guard let port = Int(portText) else { return }
//                        self.settings.clientPort = port
//                    }))
//                        .font(.system(.body, design: .monospaced))
//                        .padding(5)
//                        .background(Color.primary.opacity(0.1))
//                        .cornerRadius(5)
//                }
                
                Spacer()
                
                HStack {
                    Text(signature())
                    Spacer()
                    Text("by Hexagons")
                        .onTapGesture {
                            guard let url = URL(string: "http://hexagons.net/") else { return }
                            UIApplication.shared.open(url)
                    }
                }
                    .font(.caption)
                    .opacity(0.5)
                    
            }
                .padding()
        }
    }
    func signature() -> String {
        guard let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else { return "" }
//        guard let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else { return "" }
        return "VJ \(version)"
    }
}

struct OSCSettingsPopupView_Previews: PreviewProvider {
    static var previews: some View {
        OSCSettingsPopupView(osc: OSC.main,
                             settings: Settings.main,
                             connection: Connection.main)
    }
}
