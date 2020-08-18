//
//  BG.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-18.
//

import SwiftUI

extension View {
    
    func bg() -> some View {
        self
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .opacity(0.1)
        )
    }
    
}
