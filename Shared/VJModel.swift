//
//  VJ.swift
//  VJ
//
//  Created by Hexagons with Cappuccino on 2020-08-12.
//
//  Noise is just distant reflected sounds.
//

import Foundation

class VJModel: ObservableObject {
    
    @Published var opacity: Double = 1.0
    
    @Published var tap: Bool = false
//    @Published var tapIndexPre: Int = 0
//    @Published var tapIndexPost: Int = 0

//    func onTap() {
//        tap = true
//        tapIndexPre += 1
//        RunLoop.current.add(Timer(timeInterval: 1.0 / 6.0, repeats: false, block: { _ in
//            self.tap = false
//            self.tapIndexPost += 1
//        }), forMode: .common)
//    }
    
}
