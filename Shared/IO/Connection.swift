//
//  WiFi.swift
//  Clean OSC 2
//
//  Created by Anton Heestand on 2019-11-25.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import Foundation

class Connection: ObservableObject {

    static let main = Connection()

    @Published var wifi: Bool?
    @Published var ipAddress: String?
    
    let reachability: Reachability
    
    init() {
        
        reachability = try! Reachability()
        
        check()
        monitor()
        
    }
    
    func monitor() {
        print("Clean - Connection - Monitor")
        
        reachability.whenReachable = { reachability in
            self.wifi = reachability.connection == .wifi
            self.check()
        }
        reachability.whenUnreachable = { _ in
            self.wifi = false
            self.check()
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func check() {
        print("Clean - Connection - Check")
        let addresses = getAddresses()
        var ipAddress: String?
        let targets: [String] = ["192", "172", "127", "10"]
        loop: for target in targets {
            for address in addresses {
                let address_components = address.components(separatedBy: ".")
                if address_components[0] == target {
                    ipAddress = address
                    break loop
                }
            }
        }
        self.ipAddress = ipAddress
    }
    
    func stop() {
        reachability.stopNotifier()
    }
    
    func getAddresses() -> [String] {
        var addresses = [String]()

        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return [] }
        guard let firstAddr = ifaddr else { return [] }

        // For each interface ...
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            var addr = ptr.pointee.ifa_addr.pointee

            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {

                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        let address = String(cString: hostname)
                        addresses.append(address)
                    }
                }
            }
        }

        freeifaddrs(ifaddr)
        return addresses
    }
    
}
