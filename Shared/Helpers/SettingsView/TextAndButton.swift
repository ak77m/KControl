//
//  TextAndButton.swift
//  KControl
//
//  Created by ak77m on 17.04.2022.
//

import SwiftUI

struct TextAndButton: View {
    let text: String
    let button: String
    @Binding var alert: Bool
    let tapAction: (()->())
    let alertAction: (()->())
    
    var body: some View {
        HStack{
            Text(text)
            Spacer()
            Button(button) { tapAction() }
                .alert("Внимание! Список будет удален без возможности восстановления.", isPresented: $alert) {
                    Button("Отмена", role: .cancel) { }
                    Button("Удалить") { alertAction() }
                }
        }.padding(.vertical, 10)
    }
}

