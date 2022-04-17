//
//  PowerManagerView.swift
//  KControl (macOS)
//
//  Created by ak77m on 02.04.2022.
//

import SwiftUI

struct PowerManagerView: View {
    @EnvironmentObject var viaButtons: ButtonsManager
    @EnvironmentObject var via : TelnetManager
    @State private var newHost = HostInfo()
    @State private var edStatus = false
    
    var body: some View {
        VStack{
            HStack {
                Button(action: {via.powerOff(viaButtons.viaHost)}) {
                    Text("Выключить")
                    Image(systemName: "power.circle.fill" )
                }
                Spacer()
                
                Button(action: { via.reboot(viaButtons.viaHost) }) {
                    Text("Перезагрузить")
                    Image(systemName: "speedometer")
                }
            }.padding(.vertical)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 15.0) {
                Text("Сетевые установки стройства")
                
                Toggle("Изменить адрес", isOn: $edStatus)
                
                VStack{
                    MyTextField(symbol: "pc", comment: "IP адрес устройства", disabled: !edStatus, field: $newHost.ipAddress)
                    MyTextField(symbol: "keyboard", comment: "Маска сети", disabled: !edStatus, field: $newHost.ipMask)
                    MyTextField(symbol: "keyboard", comment: "Шлюз", disabled: !edStatus, field: $newHost.ipGateway)
                    MyTextField(symbol: "keyboard", comment: "DNS Server", disabled: !edStatus, field: $newHost.DnsServer)
                    MyTextField(symbol: "keyboard", comment: "Имя устройства", disabled: !edStatus, field: $newHost.hostName)
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 3).stroke(.gray, lineWidth: 1))
            
            Spacer()
            WindowButtons(tapAction: {
                via.setNewIpAdress(newHost)
            })

        }
        .frame(minWidth: 300, minHeight: 200)
        .padding()
        .onAppear() {
            newHost = via.getHostInfo(viaButtons.viaHost)
        }
    }
}

struct PowerManagerView_Previews: PreviewProvider {
    static var previews: some View {
        PowerManagerView()
    }
}
