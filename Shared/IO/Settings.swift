//
//  Settings.swift
//  Clean OSC 2
//
//  Created by Hexagons on 2019-11-23.
//  Copyright © 2019 Hexagons. All rights reserved.
//

import Foundation
import CoreData

class Settings: ObservableObject {
    
    static let main = Settings()
    
    static let kDefaultClientAddress: String = "0.0.0.0"
    static let kDefaultClientPort: Int = 8000
    static let kDefaultServerPort: Int = 8080
    
    static let kDefaultButtonReleaseDelay: Double = 0.1

    
    @Published var clientAddress: String {
        didSet {
            UserDefaults.standard.set(clientAddress, forKey: "setting-client-address")
            UserDefaults.standard.synchronize()
        }
    }
    @Published var clientPort: Int {
        didSet {
            UserDefaults.standard.set(clientPort, forKey: "setting-client-port")
            UserDefaults.standard.synchronize()
        }
    }
    @Published var serverPort: Int {
        didSet {
            UserDefaults.standard.set(serverPort, forKey: "setting-server-port")
            UserDefaults.standard.synchronize()
            OSC.main.startListen()
        }
    }
    
    @Published var buttonReleaseBypassed: Bool {
        didSet {
            UserDefaults.standard.set(buttonReleaseBypassed, forKey: "setting-button-release-bypassed")
            UserDefaults.standard.synchronize()
        }
    }
    @Published var buttonReleaseDelay: Double {
        didSet {
            UserDefaults.standard.set(buttonReleaseDelay, forKey: "setting-button-release-delay")
            UserDefaults.standard.synchronize()
        }
    }
    
    @Published var customOSCAddress: Bool {
        didSet {
            UserDefaults.standard.set(customOSCAddress, forKey: "setting-custom-osc-address")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    init() {
        
        let clientAddress = UserDefaults.standard.string(forKey: "setting-client-address")
        self.clientAddress = clientAddress ?? Settings.kDefaultClientAddress
        let clientPort = UserDefaults.standard.integer(forKey: "setting-client-port")
        self.clientPort = clientPort != 0 ? clientPort : Settings.kDefaultClientPort
        let serverPort = UserDefaults.standard.integer(forKey: "setting-server-port")
        self.serverPort = serverPort != 0 ? serverPort : Settings.kDefaultServerPort
        
        let buttonReleaseBypassed = UserDefaults.standard.bool(forKey: "setting-button-release-bypassed")
        self.buttonReleaseBypassed = buttonReleaseBypassed
        let buttonReleaseDelay = UserDefaults.standard.double(forKey: "setting-button-release-delay")
        self.buttonReleaseDelay = buttonReleaseDelay != 0 ? buttonReleaseDelay : Settings.kDefaultButtonReleaseDelay
        
        let customOSCAddress = UserDefaults.standard.bool(forKey: "setting-custom-osc-address")
        self.customOSCAddress = customOSCAddress
    }
    
}
