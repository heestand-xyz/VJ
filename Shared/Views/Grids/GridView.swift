//
//  GridView.swift
//  VJ (iOS)
//
//  Created by Cappuccino on 2020-08-12.
//

import SwiftUI

struct GridView: View {
    
    let yCount: Int
    @Binding var tapOnCircles: [Bool]
    var hint: Bool = false
    var beOdd: Bool = true
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black
                if geo.size.height > 0.0 {
                    
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: length(size: geo.size) - 0.1), spacing: 0.0)
                    ], spacing: 0.0, content: {
                        ForEach(0..<count(size: geo.size)) { i in
                            if i < tapOnCircles.count {
                                
                                CircleView(on: isOn(at: i), hint: hint)
                                    .onInteract(on: isOn(at: i))
                                    .frame(width: length(size: geo.size),
                                           height: length(size: geo.size))
                                
                            }
                        }
                    })
                    .frame(width: length(size: geo.size) * CGFloat(xCount(size: geo.size)),
                           height: length(size: geo.size) * CGFloat(yCount))
                    
                }
            }
            .onAppear {
                guard geo.size.height > 0.0 else { return }
                tapOnCircles = [Bool](repeating: false, count: count(size: geo.size))
            }
        }
    }
    
    func isOn(at index: Int) -> Binding<Bool> {
        Binding<Bool> {
            guard index < tapOnCircles.count else { return false }
            return tapOnCircles[index]
        } set: { on in
            guard index < tapOnCircles.count else { return }
            tapOnCircles[index] = on
        }

    }
    
    func xCount(size: CGSize) -> Int {
        let xCount = Int(size.width / length(size: size))
        if beOdd && xCount % 2 == 0 {
            return max(xCount - 1, 1)
        }
        return xCount
    }
    
    func count(size: CGSize) -> Int {
        xCount(size: size) * yCount
    }
    
    func length(size: CGSize) -> CGFloat {
        size.height / CGFloat(yCount)
    }
    
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(yCount: 3, tapOnCircles: .constant([]), hint: true)
    }
}
