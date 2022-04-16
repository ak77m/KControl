//
//  ListOfButtons.swift
//  KControl
//
//  Created by ak77m on 19.03.2022.
//

import SwiftUI
import AVFoundation

struct ListOfButtons: View {
    @EnvironmentObject var kButtons: ButtonsManager
    @EnvironmentObject var network : NetworkManager
    
    @State private var isEditButton = false
    @State private var commandOk = false
    
    let columns = Array(repeating: GridItem(.flexible(minimum: 120, maximum: 400)), count: 2)
    
    var body: some View {
        
        ScrollView{
            LazyVGrid(columns: columns, spacing: 10){
                ForEach(kButtons.kButtonsList, id: \.id) { item in
                    
                    ButtonView(item: item)
                        .modifier(PressModifier(tapAction: {
                            commandOk = network.sendCommand(kButtons.kIpAddress, knet: item.kNetDevice, devID : item.kNetId)
                            AudioServicesPlaySystemSound(3)
                        }, longPressAction: { }, mainColor: item.color1))
                    
                        .contextMenu{
                            Button("Редактировать", action: {
                                kButtons.kActiveItem = item
                                isEditButton.toggle()
                            })
                            Button("Удалить", action: {
                                kButtons.deleteItem(item)
                            })
                        }
                }
            }
        }
        .sheet(isPresented: $isEditButton) {
            NewButton()
        }
    }
    
}

struct ListOfButtons_Previews: PreviewProvider {
    static var previews: some View {
        ListOfButtons()
    }
}
