//
//  Pad.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-18.
//

import SwiftUI
import MultiplatformTypes

struct Pad: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var on: Bool
    
    var title: String?
    var systemImage: String?
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .opacity(on ? 1.0 : 0.2)
                .onInteract(on: $on)
            
            Group {
                if let title: String = title,
                   let systemImage: String = systemImage {
                    Label(title, systemImage: systemImage)
                        .mono()
                } else if let systemImage: String = systemImage {
                    Image(systemName: systemImage)
                        .mono()
                } else if let title: String = title {
                    Text(title)
                        .mono()
                }
            }
            .foregroundColor(on != (colorScheme == .light) ? .black : .white)
            .padding()
            
        }
        
    }
    
}

struct Pad_Previews: PreviewProvider {
    static var previews: some View {
        Pad(on: .constant(true))
    }
}
