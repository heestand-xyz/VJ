//
//  Mono.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-18.
//

import SwiftUI

extension View {
    
    func mono() -> some View {
        self.font(.system(size: 15,
                          weight: .black,
                          design: .monospaced))
    }
    
}
