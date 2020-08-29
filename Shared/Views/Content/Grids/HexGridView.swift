//
//  HexGridView.swift
//  VJ (iOS)
//
//  Created by Cappuccino on 2020-08-12.
//

import SwiftUI

struct HexGridView: View {
    
    let yCount: Int
    @Binding var corner: CGFloat
    var asCircle: Bool = false
    @Binding var grid: [Bool]
    var hint: Bool = false
    var beOdd: Bool = true
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black
                if geo.size.height > 0.0 {
                    
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: width(size: geo.size) - 0.1), spacing: 0.0)
                    ], spacing: 0.0, content: {
                        ForEach(0..<count(size: geo.size)) { i in
                            if i < grid.count {

                                HexView(hint: hint,
                                        asCircle: asCircle,
                                        isOn: isOn(at: i),
                                        corner: $corner,
                                        length: length(size: geo.size),
                                        width: width(size: geo.size),
                                        height: height(size: geo.size),
                                        isOddRow: isOddRow(at: i, size: geo.size),
                                        isOutside: isOutside(at: i, size: geo.size))

                            }
                        }
                    })
                    .frame(width: width(size: geo.size) * CGFloat(xCount(size: geo.size)),
                           height: height(size: geo.size) * CGFloat(yCount - 1) + length(size: geo.size))
                    
                }
            }
            .onAppear {
                guard geo.size.height > 0.0 else { return }
                grid = [Bool](repeating: false, count: count(size: geo.size))
            }
        }
    }
    
    func isOddRow(at index: Int, size: CGSize) -> Bool {
        let vCount: Int = (yCount - 1) / 2
        var yCenter: Int = y(at: index, size: size) - vCount
        while yCenter < 0 {
            yCenter += 2
        }
        return yCenter % 2 == 1
    }
    
    func isOutside(at index: Int, size: CGSize) -> Bool {
        if isOddRow(at: index, size: size) {
            if x(at: index, size: size) == xCount(size: size) - 1 {
                return true
            }
        }
        return false
    }
    
    func isOn(at index: Int) -> Binding<Bool> {
        Binding<Bool> {
            guard index < grid.count else { return false }
            return grid[index]
        } set: { on in
            guard index < grid.count else { return }
            grid[index] = on
        }

    }
    
    func xCount(size: CGSize) -> Int {
        let xCount = Int(size.width / width(size: size))
        if beOdd && xCount % 2 == 0 {
            return max(xCount - 1, 1)
        }
        return xCount
    }
    
    func count(size: CGSize) -> Int {
        xCount(size: size) * yCount
    }
    
    func y(at index: Int, size: CGSize) -> Int {
        index / xCount(size: size)
    }
    
    func x(at index: Int, size: CGSize) -> Int {
        index % xCount(size: size)
    }
    
    func length(size: CGSize) -> CGFloat {
        (size.height * 0.99) / (CGFloat(yCount - 1) * (3 / 4) + 1.0)
    }
    
    func width(size: CGSize) -> CGFloat {
        length(size: size) * sqrt(3 / 4)
    }
    
    func height(size: CGSize) -> CGFloat {
        length(size: size) * (3 / 4)
    }
    
}

struct HexGridView_Previews: PreviewProvider {
    static var previews: some View {
        HexGridView(yCount: 3, corner: .constant(0.0), grid: .constant([]), hint: true)
    }
}
