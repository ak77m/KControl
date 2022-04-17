//
//  NewButton.swift
//  KControl
//
//  Created by ak77m on 18.03.2022.
//

import SwiftUI

struct NewButton: View {
    @EnvironmentObject var kButtons: ButtonsManager
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                    
                Section("Эмуляция устройства") {
                    VStack{
                        Picker("K-Net устройство", selection: $kButtons.kActiveItem.kNetDevice) {
                            ForEach(0...10, id: \.self) { Text("\($0)") }
                        }
                        
                        Picker("Номер кнопки ", selection: $kButtons.kActiveItem.kNetId) {
                            ForEach(0...10, id: \.self) { Text("\($0)") }
                        }
                    }
                    .padding(.horizontal)
                    .pickerStyle(.segmented)
                        
                    
                }.padding(.vertical, 5)
                
                Section("Текст кнопки") {
                    VStack{
                        
                        MyTextField(symbol: "note.text.badge.plus", comment: "Название кнопки",
                                    disabled: false, field: $kButtons.kActiveItem.label)
                        MyTextField(symbol: "note.text.badge.plus", comment: "Коментарий",
                                    disabled: false, field: $kButtons.kActiveItem.description)
                       
                        Picker("Выбор картинки", selection: $kButtons.kActiveItem.image) {
                            ForEach(kButtons.emoji, id: \.self) { Text("\($0)") }
                        }
                        .padding(.horizontal)
                        .overlay(RoundedRectangle(cornerRadius: 2, style: .continuous)
                            .stroke(.gray, lineWidth: 1))
                        .pickerStyle(.menu)
                        
                    }.padding(.horizontal)
                }.padding(.vertical, 5)
                
                Section("Цвет кнопки") {
                    HStack{
                        Text("Цвет кнопки")
                        Spacer()
                        ColorPicker("",selection: $kButtons.kActiveItem.color1)
                            .labelsHidden()
                            .frame(minWidth: 50, maxWidth: 100, minHeight: 50, maxHeight: 100)
                    }
                }.padding(.vertical, 5)
            }
            Spacer()
            
            WindowButtons(tapAction: { kButtons.updateOrNewItem() })

        }
        
        .navigationTitle("Новая кнопка")
        .frame(minWidth: 300, minHeight: 200)
        .padding()
        
    }
}

struct NewButton_Previews: PreviewProvider {
    static var previews: some View {
        NewButton()
    }
}
