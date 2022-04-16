//
//  SetupView.swift
//  KControl (iOS)
//
//  Created by ak77m on 22.03.2022.
//

import SwiftUI

struct SetupView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var kButtons: ButtonsManager
    @EnvironmentObject var network : NetworkManager
    
    @State private var deleteAlert = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            Form {
                Section(header: Text("IP адрес контроллера ")) {
                    TextField("Master RC", text: $kButtons.kIpAddress)
                    TextField("Пароль (если требуется)", text: $kButtons.kHostPassword)
                }
                
                
                
                Section(header: Text("Импорт конфигурации")) {
                    HStack{
                        Text("Получить список")
                        Spacer()
                        Button("Запрос") { network.getConfigFromController(kButtons.kIpAddress) }
                    }
                    Text("Ответ : \(network.response)")
                }
                
                Section(header: Text("Очистка")) {
                    HStack{
                        Text("Удалить список")
                        Spacer()
                        Button("Очистка") { deleteAlert.toggle() }
                            .alert("Внимание! Список будет удален без возможности восстановления.", isPresented: $deleteAlert) {
                            Button("Отмена", role: .cancel) { }
                            Button("Удалить") { kButtons.deleteList()  }
                            }
                    }
                }
                
                HStack{
                    Spacer()
                    Button("Применить") {
                        if !network.configFromDevice.isEmpty {
                            print("Ok")
                            kButtons.kButtonsList = network.configFromDevice
                            _ = kButtons.saveListOfButtons()
                        }
                        
                        kButtons.saveDefaults()
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    
                }
                
            }
        }
    }
    
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}
