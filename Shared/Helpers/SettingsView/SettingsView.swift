//
//  SettingsView.swift
//  KControl
//
//  Created by ak77m on 19.03.2022.
//

import SwiftUI

struct SettingsView: View {
#if os(iOS)
    @Environment(\.presentationMode) var presentationMode
#endif
    @EnvironmentObject var kButtons: ButtonsManager
    @EnvironmentObject var network : NetworkManager
    
    @State private var alwaysFalse = false
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
                
                DisclosureGroup("Импорт и очистка конфигурации") {
                    VStack(alignment: .leading, spacing: 10){
                        
                        TextAndButton(text: "Получить список из контроллера",
                                      button: " Запрос ", alert: $alwaysFalse,
                                      tapAction: {},
                                      alertAction: { getConfig() })
                        
                        TextAndButton(text: "Очистить список K-Net кнопок",
                                      button: " Удалить ", alert: $kDeleteAlert,
                                      tapAction:   {kDeleteAlert.toggle() },
                                      alertAction: {kButtons.kListClear()})
                        
                        TextAndButton(text: "Очистить список VIA кнопок",
                                      button: " Удалить ", alert: $viaDeleteAlert,
                                      tapAction:   {viaDeleteAlert.toggle() },
                                      alertAction: {kButtons.viaListClear()})
                        
                    }.padding()
                    
                }
                Spacer(minLength: 30)
                
            }
            //Button("Применить") { confirm() }
        }
        .padding(15)
#if os(macOS)
        .frame(minWidth: 400, maxWidth: 400, minHeight: 400, maxHeight: 400)
#endif
        
    }
    
    func getConfig () {
        
        network.getConfigFromController(kButtons.kIpAddress)
        if !network.configFromDevice.isEmpty {
            kButtons.kButtonsList = network.configFromDevice
        }
        kButtons.saveDefaults()
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
