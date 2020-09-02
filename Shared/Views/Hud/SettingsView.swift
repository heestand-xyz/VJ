//
//  SettingsView.swift
//  VJ
//
//  Created by Cappuccino on 2020-08-16.
//

import SwiftUI
import MultiplatformTypes

struct SettingsView: View {
    
    @ObservedObject var vj: VideoJockey
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            // Opacity
            HStack(spacing: 20) {
            
                Button {
                    vj.opacity = 0.0
                } label: {
                    Image(systemName: "sun.min" + (vj.opacity == 0.0 ? "" : ".fill"))
                }
                .disabled(vj.opacity == 0.0)
                
                Slider(value: $vj.opacity)
                
                Button {
                    vj.opacity = 1.0
                } label: {
                    Image(systemName: "sun.max" + (vj.opacity == 1.0 ? "" : ".fill"))
                }
                .disabled(vj.opacity == 1.0)
                
            }
            .buttonStyle(PlainButtonStyle())
            .font(.system(size: 30))
            .bg()
            
            HStack(alignment: .top, spacing: 20) {
                
                VStack {
                    BasicToggle(isOn: $vj.preview)
                    Label("View", systemImage: "rectangle.dashed")
                        .mono()
                }
                .bg()
                
                Picker("", selection: $vj.aspectRatio) {
                    Text("16 / 9")
                        .tag(CGFloat(16.0 / 9.0))
                    Text("16 / 10")
                        .tag(CGFloat(16.0 / 10.0))
                    Text("4 / 3")
                        .tag(CGFloat(4.0 / 3.0))
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                
            }
            
            HStack(alignment: .top, spacing: 20) {
                
                Pad(on: $vj.test, title: "Test", systemImage: "diamond")
                    .frame(width: 100, height: 100)
                
                Pad(on: $vj.tag, title: "TAG")
                    .frame(width: 100, height: 100)
                
                Spacer()
                
            }
            
            HStack(spacing: 15) {
                Text("Padding")
                Slider(value: $vj.padding, in: 0.0...0.1)
            }
            .mono()
            .bg()
            
        }
        .padding(.horizontal)
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(vj: VideoJockey())
    }
}
