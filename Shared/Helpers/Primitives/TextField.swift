//
//  TextField.swift
//  KControl
//
//  Created by ak77m on 02.04.2022.
//  Original idea by Stewart Lynch on 2020-05-08.

import SwiftUI

struct MyTextField: View {
    var symbol: String
    var comment: String
    var disabled = false
    @Binding var field: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: symbol)
                    .foregroundColor(.gray)
                    .font(.headline)
                TextField(comment, text: $field).textFieldStyle(.plain)
                    //.autocapitalization(.none)
            }
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 3).stroke(.gray, lineWidth: 1))
            
        }
        .disabled(disabled)
        .opacity(disabled ? 0.5 : 1.0)
    }
}
