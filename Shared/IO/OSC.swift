//
//  OSC.swift
//  Clean OSC 2
//
//  Created by Anton Heestand on 2019-11-26.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import SwiftUI
import OSCKit

class OSC: NSObject, ObservableObject, OSCClientDelegate & OSCPacketDestination {
    
    static let main = OSC()
    
    let server: OSCServer
    let client: OSCClient
    
    @Published var resentInput: Bool = false
    var resentInputTimer: Timer?
    
    @Published var resentOutput: Bool = false
    var resentOutputTimer: Timer?
        
    var messageCallback: ((String, Any) -> ())?
    
    override init() {
        
        server = OSCServer()
        client = OSCClient()
        
        super.init()
        
        client.delegate = self
        server.delegate = self
        
        updateSettings()
        
    }
    
    func updateSettings() {
        
        client.host = Settings.main.clientAddress
        client.port = UInt16(Settings.main.clientPort)
        server.port = UInt16(Settings.main.serverPort)

    }
    
    func startListen() {
        
        print("Clean - OSC - Listen")
        
        try? server.startListening()
        
    }
    
    func send(value: Any, as address: String) {
        
        let message = OSCMessage(with: "/" + address, arguments: [value])
        
        client.send(packet: message)
        
        setResentOutput()

    }
    
    // MARK: - OSC Server Delegate
    
    func handle(_ message: OSCMessage!) {
        let address = message.addressPattern.replacingOccurrences(of: "/", with: "")
        guard let value = message.arguments.first else { return }
        messageCallback?(address, value)
        setResentInput()
    }
    
    // MARK: - Recent
    
    func setResentInput() {
        resentInput = true
        resentInputTimer?.invalidate()
        resentInputTimer = Timer(timeInterval: 0.25, repeats: false, block: { t in
            self.resentInput = false
        })
        RunLoop.current.add(resentInputTimer!, forMode: .common)
    }
    
    func setResentOutput() {
        resentOutput = true
        resentOutputTimer?.invalidate()
        resentOutputTimer = Timer(timeInterval: 0.25, repeats: false, block: { t in
            self.resentOutput = false
        })
        RunLoop.current.add(resentOutputTimer!, forMode: .common)
    }
    
    // MARK: - OSC Delegates
    
    func clientDidConnect(client: OSCClient) {}
    
    func clientDidDisconnect(client: OSCClient) {}
    
    func take(message: OSCMessage) {
        handle(message)
    }
    
    func take(bundle: OSCBundle) {
        guard let message: OSCMessage = bundle.elements.first as? OSCMessage else { return }
        handle(message)
    }
    
}
