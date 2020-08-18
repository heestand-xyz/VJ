//
//  VJApp.swift
//  Shared
//
//  Created by Cappuccino on 2020-08-12.
//
//  VJ no motion based on time.
//  VJ no light without action.
//

import SwiftUI

@main
struct VJApp: App {
    @StateObject var vj = VideoJockey()
    var body: some Scene {
        WindowGroup {
            ContentView(vj: vj)
        }
    }
}
