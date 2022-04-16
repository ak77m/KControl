//
//  WindowButtons.swift
//  KControl
//
//  Created by ak77m on 02.04.2022.
//

import SwiftUI

struct WindowButtons: View {
    @Environment(\.presentationMode) var presentationMode
    let tapAction: (()->())
    var body: some View {
        HStack{
            Button(" Назад ") {
                presentationMode.wrappedValue.dismiss()
                
            }
            Button("Применить") {
                tapAction()
                presentationMode.wrappedValue.dismiss()
            }
            
        }.padding(.vertical, 10)
    }
}

struct WindowButtons_Previews: PreviewProvider {
    static var previews: some View {
        WindowButtons(tapAction: {})
    }
}
