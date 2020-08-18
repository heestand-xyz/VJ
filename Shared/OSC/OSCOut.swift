//
//  OSCOut.swift
//  VJ (iOS)
//
//  Created by Cappuccino on 2020-08-18.
//

import Foundation
import OSCKit

class OSCOut: ObservableObject, OSCClientDelegate, OSCPacketDestination {
    
    let client: OSCClient
    
    @Published var connected: Bool = false
    
    init() {
        
        client = OSCClient()
        client.interface = "en0"
        client.host = "10.101.100.101"
        client.port = 24601
        client.useTCP = true
        client.delegate = self
        
    }
    
    func send() {
        let message = OSCMessage(with: "/osc/kit",
                                 arguments: [1,
                                             3.142,
                                             "hello world!",
                                             Data(count: 2),
                                             OSCArgument.oscTrue,
                                             OSCArgument.oscFalse,
                                             OSCArgument.oscNil,
                                             OSCArgument.oscImpulse])
        client.send(packet: message)
    }
    
    // MARK: - Client
    
    func clientDidConnect(client: OSCClient) {
        print("VJ OSC Out clientDidConnect client:", client.interface)
        connected = true
    }
    
    func clientDidDisconnect(client: OSCClient) {
        print("VJ OSC Out clientDidDisconnect client:", client.interface)
        connected = false
    }
    
    // MARK: - Packet
    
    func take(message: OSCMessage) {
        print("VJ OSC Out take message:", message.arguments)
    }
    
    func take(bundle: OSCBundle) {
        print("VJ OSC Out take bundle:", bundle.elements)
    }
    
    
}
