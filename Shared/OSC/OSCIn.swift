//
//  OSCIn.swift
//  VJ (iOS)
//
//  Created by Cappuccino on 2020-08-18.
//

import Foundation
import OSCKit

class OSCIn: ObservableObject, OSCPacketDestination {
    
    let server: OSCServer
        
    init() {
        
        server = OSCServer()
        server.interface = "en0"
        server.port = 24601
        server.delegate = self
        
    }
    
    // MARK: - Packet
    
    func take(message: OSCMessage) {
        print("VJ OSC In take message:", message.arguments)
    }
    
    func take(bundle: OSCBundle) {
        print("VJ OSC In take bundle:", bundle.elements)
    }
    
    
}
