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
    
    @Published var yCount: Int = 3
    
    @Published var flash: Bool = false
//    {
//        didSet {
//            guard flash else { return }
//            guard !flashing else { return }
//            flashing = true
//            time(3.0 / 100) {
//                self.flashing = false
//            }
//        }
//    }
//    @Published var flashing: Bool = false
    
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
    
    private func time(_ duration: Double, done: @escaping () -> ()) {
        RunLoop.current.add(Timer(timeInterval: duration, repeats: false, block: { _ in done() }), forMode: .common)
    }
    
}
