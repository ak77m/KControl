//
//  ViaTopView.swift
//  KControl (macOS)
//
//  Created by ak77m on 29.03.2022.
//

import SwiftUI

struct ViaTopView: View {
    @EnvironmentObject var kButtons: ButtonsManager
    @State private var addView = false
    @State private var powerView = false
    
    var body: some View {
        HStack{
            Button(action: {
                powerView.toggle()
            }, label: {
                Image(systemName: "power.circle")
            })
            Spacer()
            Text("\(kButtons.viaHost.ipAddress)").font(.title3)
            Spacer()
            
            Button(action: {
                kButtons.viaActiveItem = ViaButtonStyle()
                addView.toggle()
                
            }, label: {
                Image(systemName: "plus.circle")
            })
        }
        .buttonStyle(.plain)
        .padding(.vertical, 5)
        .font(.title)
        
        .sheet(isPresented: $addView) {
            NewViaButtonView()
        }
        .sheet(isPresented: $powerView) {
            PowerManagerView()
        }
        //.padding(.horizontal, 10)
    }
}

struct ViaTopView_Previews: PreviewProvider {
    static var previews: some View {
        ViaTopView()
    }
}
