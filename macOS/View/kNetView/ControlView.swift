//
//  ControlView.swift
//  KControl
//
//  Created by ak77m on 18.03.2022.
//

import SwiftUI

struct ControlView: View {
    @EnvironmentObject var kButtons: ButtonsManager
    //@State private var activeSheet: ActiveSheet?
    @State private var addView = false
    
    var body: some View {
        HStack{
            Spacer()
            Text("\(kButtons.kIpAddress)").font(.title3)
            Spacer()
            
            Button(action: {
                kButtons.kActiveItem = KButtonStyle()
                addView.toggle()
                
            }, label: {
                Image(systemName: "plus.circle")
            })
            
        }
        .buttonStyle(.plain)
        .padding(.vertical, 5)
        .font(.title)
        
        .sheet(isPresented: $addView) {
            NewButton()
        }
        //.padding(.horizontal, 10)
    }
        
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView()
    }
}
