//
//  Button.swift
//  KControl
//
//  Created by ak77m on 18.03.2022.
//

import SwiftUI

struct ButtonView: View {
    
    var item :  KButtonStyle
    
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


