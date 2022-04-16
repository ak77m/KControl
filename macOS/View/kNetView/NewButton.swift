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
                            ForEach(0...15, id: \.self) { Text("\($0)") }
                        }
                        Picker("Номер кнопки ", selection: $kButtons.kActiveItem.kNetId) {
                            ForEach(0...15, id: \.self) { Text("\($0)") }
                        }
                    }.padding(.horizontal)
                    
                }.padding(.vertical, 5)
                
                Section("Текст кнопки") {
                    VStack{
                        TextField("Название кнопки", text: $kButtons.kActiveItem.label)
                        TextField("Коментарий", text: $kButtons.kActiveItem.description)
                        Picker("Выбор картинки", selection: $kButtons.kActiveItem.image) {
                            ForEach(kButtons.emoji, id: \.self) { Text("\($0)") }
                        }
                    }.padding(.horizontal)
                }.padding(.vertical, 5)
                
                Section("Цвет кнопки") {
                    HStack{
                        Text("Базовый цвет кнопки")
                        Spacer()
                        ColorPicker("",selection: $kButtons.kActiveItem.color1).labelsHidden()
                    }.padding(.horizontal)
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
