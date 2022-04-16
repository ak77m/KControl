//
//  NewButton.swift
//  KControl (iOS)
//
//  Created by ak77m on 22.03.2022.
//

import SwiftUI

struct NewButton: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var kButtons: ButtonsManager
    let knetAdress = [1,2,3,4,11,12,13,14]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                    
                Section("Эмуляция устройства") {
                    VStack(alignment: .leading){
                        Text("Адрес K-Net")
                        Picker("", selection: $kButtons.kActiveItem.kNetDevice) {
                            ForEach(knetAdress, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        Text("№ кнопки")
                        Picker("", selection: $kButtons.kActiveItem.kNetId) {
                            ForEach(1...10, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                    .padding()
                    .pickerStyle(.segmented)
                    
                }
                Section("Текст кнопки") {
                    TextField("Название кнопки", text: $kButtons.kActiveItem.label).padding(.horizontal)
                    TextField("Коментарий", text: $kButtons.kActiveItem.description).padding(.horizontal)
                    
                    Picker("Выбор картинки", selection: $kButtons.kActiveItem.image) {
                        ForEach(kButtons.emoji, id: \.self) {
                            Text("\($0)")
                                .padding(.vertical)
                        }
                    }
                    .padding(.horizontal)
                    .overlay(RoundedRectangle(cornerRadius: 10.0, style: .circular)
                                    .stroke(.gray, lineWidth: 1))
                    .pickerStyle(.wheel)
                }
                
                Section("Цвет кнопки") {
                    HStack{
                        Text("Цвет кнопки")
                        Spacer()
                        ColorPicker("",selection: $kButtons.kActiveItem.color1)
                    } .padding(.horizontal)
                }
            }
            
            HStack{
                Button(" Отмена ") {
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Применить") {
                    kButtons.updateOrNewItem()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.vertical, 10)
            
        }
        .navigationTitle("Новая кнопка")
        .padding(.horizontal)
    }
}

struct NewButton_Previews: PreviewProvider {
    static var previews: some View {
        NewButton()
    }
}
