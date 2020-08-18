//
//  ToggleText.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-18.
//

import SwiftUI
import MultiplatformTypes

struct ToggleText: View {
    let title: String
    @Binding var isOn: Bool
    var body: some View {
        VStack {
            BasicToggle(isOn: $isOn)
            Text(title)
                .mono()
        }
        .bg()
    }
}

struct ToggleText_Previews: PreviewProvider {
    static var previews: some View {
        ToggleText(title: "Test", isOn: .constant(true))
    }
}
