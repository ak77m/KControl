//
//  NewViaButtonView.swift
//  KControl
//
//  Created by ak77m on 30.03.2022.
//

import SwiftUI

struct NewViaButtonView: View {
    @EnvironmentObject var buttons: ButtonsManager
    @EnvironmentObject var via : TelnetManager
    
    // viaButtons.viaActiveItem.commandId жестко задает индекс в списке telnet.viaCommands
    // если этот индекс будет больше чем количество записей то будет краш. Разобраться
    @State private var p1Active = true
    @State private var p2Active = true
    @State private var p3Active = true
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Section("Команда для управления VIA") {
                    VStack{
                        Picker("", selection: $buttons.viaActiveItem.commandId) {
                            ForEach(via.commands, id: \.id) { Text("\($0.name)") }
                        }
                        .onChange(of: buttons.viaActiveItem.commandId) { isEdit($0) }
                            .labelsHidden()
                        
                        MyTextField(symbol: "note.text.badge.plus", comment: "Доп. параметр P1",
                                    disabled: p1Active, field: $buttons.viaActiveItem.p1)
                                  
                        MyTextField(symbol: "note.text.badge.plus", comment: "Доп. параметр P2",
                                    disabled: p2Active, field: $buttons.viaActiveItem.p2)
                                   
                        MyTextField(symbol: "note.text.badge.plus", comment: "Доп. параметр P3",
                                    disabled: p3Active, field: $buttons.viaActiveItem.p3)
                                 
                    }.padding(.horizontal)
                    
                }.padding(.vertical, 5)
                
                Section("виз оформление: Текст") {
                    VStack{
                        MyTextField(symbol: "circle.grid.cross.up.filled", comment: "Название кнопки",
                                    field: $buttons.viaActiveItem.label)
                        MyTextField(symbol: "circle.grid.cross.down.filled", comment: "Коментарий",
                                    field: $buttons.viaActiveItem.description)
                        
                        Picker("Выбор картинки", selection: $buttons.viaActiveItem.image) {
                            ForEach(buttons.emoji, id: \.self) { Text("\($0)") }
                        }
                    }.padding(.horizontal)
                }.padding(.vertical, 5)
                
                Section("Цвет фона кнопки") {
                    HStack{
                        Text("Базовый цвет кнопки")
                        Spacer()
                        ColorPicker("",selection: $buttons.viaActiveItem.color1)
                    }.padding(.horizontal)
                }.padding(.vertical, 5)
            }
            .onAppear() {
                // To check with fields can be editable
                let id = buttons.viaActiveItem.commandId
                isEdit(id)
            }
            
            Spacer()
            
            WindowButtons(tapAction: {
                buttons.updateOrNewViaItem()
            })
        }
        .frame(minWidth: 300, minHeight: 200)
        .padding()
    }
    
    /// Сравниваем текущий id команды с id в массиве команд на предмет возможности редактирования кастомного поля
    func isEdit(_ id: Int) {
        (buttons.viaActiveItem, p1Active, p2Active, p3Active) = via.checkCommandStatus(buttons.viaActiveItem, index: id)
    }
    
}

struct NewViaButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NewViaButtonView()
    }
}
