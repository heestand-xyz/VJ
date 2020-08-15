//
//  VJApp.swift
//  Shared
//
//  Created by Cappuccino on 2020-08-12.
//

import SwiftUI

@main
struct VJApp: App {
    @StateObject var vj = VJModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vj)       
        }
    }
}
