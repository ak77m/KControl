//
//  SettingsView.swift
//  KControl
//
//  Created by ak77m on 19.03.2022.
//

import SwiftUI

struct SettingsView: View {
    // @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var kButtons: ButtonsManager
    @EnvironmentObject var network : NetworkManager
    
    @State private var kDeleteAlert = false
    @State private var viaDeleteAlert = false
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                
                Section(header: Text("IP адрес контроллера K-Net")) {
                    VStack(alignment: .leading){
                        
                        MyTextField(symbol: "link", comment: "Master RC",
                                    field: $kButtons.kIpAddress)
                        MyTextField(symbol: "key", comment: "Пароль (если требуется)",
                                    field: $kButtons.kHostPassword)
                    }.padding(15)
                }
                
                Section(header: Text("IP адрес VIA")) {
                    VStack(alignment: .leading){
                        MyTextField(symbol: "link", comment: "IP адрес",
                                    field: $kButtons.viaHost.ipAddress)
                        MyTextField(symbol: "person", comment: "Логин",
                                    field: $kButtons.viaHost.login)
                        MyTextField(symbol: "key", comment: "Пароль",
                                    field: $kButtons.viaHost.password)
                    }.padding(15)
                }
                
                Section(header: Text("Импорт конфигурации")) {
                    VStack(alignment: .leading){
                        HStack{
                            Text("Получить список из контроллера")
                            Spacer()
                            Button(" Запрос ") { network.getConfigFromController(kButtons.kIpAddress) }
                        }
                        
                        HStack{
                            Text("Удалить список K-Net кнопок")
                            Spacer()
                            Button("Очистка") { kDeleteAlert.toggle() }
                                .alert("Внимание! Список будет удален без возможности восстановления.", isPresented: $kDeleteAlert) {
                                    Button("Отмена", role: .cancel) { }
                                    Button("Удалить") { kButtons.deleteList()  }
                                }
                        }
                        
                        HStack{
                            Text("Удалить список VIA кнопок")
                            Spacer()
                            Button("Очистка") { viaDeleteAlert.toggle() }
                                .alert("Внимание! Список будет удален без возможности восстановления.", isPresented: $viaDeleteAlert) {
                                    Button("Отмена", role: .cancel) { }
                                    Button("Удалить") { kButtons.deleteViaList()  }
                                }
                        }
                    }.padding(15)
                }
                Spacer()
                
            }
            //.padding(.vertical, 50.0)
            Button("Применить") { confirm() }
        }
        .padding(15)
        .frame(minWidth: 400, maxWidth: 400, minHeight: 400, maxHeight: 400)
        
        
    }
    
    func confirm () {
        if !network.configFromDevice.isEmpty {
            kButtons.kButtonsList = network.configFromDevice
            if kButtons.saveListOfButtons() { network.response = "Сохранено" }
        }
        kButtons.saveDefaults()
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
