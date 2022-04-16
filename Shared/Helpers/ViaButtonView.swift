//
//  ViaButtonView.swift
//  KControl
//
//  Created by ak77m on 30.03.2022.
//

import SwiftUI

struct ViaButtonView: View {
    var item :  ViaButtonStyle
    
    var body: some View {
        HStack(alignment: .center){
            Spacer()
            #if os(macOS)
            Text(item.image).font(.system(size: 50))
            #else
            Text(item.image).font(.largeTitle)
            #endif
            
            VStack(spacing: 9.0){
                Text(item.label).fontWeight(.bold)
                Text(item.description)
            }
            
            Spacer()
        }
        .frame(height: 90, alignment: .center)
    }
}

struct ViaButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ViaButtonView(item: ViaButtonStyle())
    }
}
