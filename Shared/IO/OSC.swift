//
//  OSC.swift
//  Clean OSC 2
//
//  Created by Anton Heestand on 2019-11-26.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import SwiftUI
import OSCKit

class OSC: NSObject, ObservableObject, OSCServerDelegate {
    
    static let main = OSC()
    
    let server: OSCServer
    let client: OSCClient
    
    @Published var serverStarted: Bool = false
    
    @Published var resentInput: Bool = false
    var resentInputTimer: Timer?
    
    @Published var resentOutput: Bool = false
    var resentOutputTimer: Timer?
        
    var messageCallback: ((String, Any) -> ())?
    
    override init() {
        
        server = OSCServer()
        client = OSCClient()
        
        super.init()
        
        server.delegate = self
        
    }
    
    func startListen() {
        
        print("Clean - OSC - Listen")
        
        if serverStarted {
            server.stop()
            serverStarted = false
        }
        
        let port = Int(Settings.main.serverPort)
        if isPortOpen(port) {
            server.listen(port)
            serverStarted = true
            print("Clean - OSC - Listen - Started")
        } else {
            print("Clean - OSC - Listen - Failed")
        }
        
    }
    
    func send(value: Any, as address: String) {
        
        let udp = "udp://\(Settings.main.clientAddress):\(Settings.main.clientPort)"

        let message = OSCMessage(address: "/" + address, arguments: [value])
        
        print("Clean - OSC - Send:", udp, "/" + address, value)
        client.send(message, to: udp)
        
        setResentOutput()

    }
    
    // MARK: - OSC Server Delegate
    
    func handle(_ message: OSCMessage!) {
        let address = message.address.replacingOccurrences(of: "/", with: "")
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
    
    // MARK: - Port
    
    func isPortOpen(_ portNumber: Int) -> Bool {
        
        let port = in_port_t(exactly: portNumber) ?? 0

        let socketFileDescriptor = socket(AF_INET, SOCK_STREAM, 0)
        if socketFileDescriptor == -1 {
            return false
        }

        var addr = sockaddr_in()
        let sizeOfSockkAddr = MemoryLayout<sockaddr_in>.size
        addr.sin_len = __uint8_t(sizeOfSockkAddr)
        addr.sin_family = sa_family_t(AF_INET)
        addr.sin_port = Int(OSHostByteOrder()) == OSLittleEndian ? _OSSwapInt16(port) : port
        addr.sin_addr = in_addr(s_addr: inet_addr("0.0.0.0"))
        addr.sin_zero = (0, 0, 0, 0, 0, 0, 0, 0)
        var bind_addr = sockaddr()
        memcpy(&bind_addr, &addr, Int(sizeOfSockkAddr))

        if Darwin.bind(socketFileDescriptor, &bind_addr, socklen_t(sizeOfSockkAddr)) == -1 {
            return false
        }
        if listen(socketFileDescriptor, SOMAXCONN) == -1 {
            return false
        }
        return true
    }
    
}
