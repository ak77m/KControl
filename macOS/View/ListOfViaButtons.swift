//
//  ListOfViaButtons.swift
//  KControl (macOS)
//
//  Created by ak77m on 30.03.2022.
//

import SwiftUI
import AVFoundation

struct ListOfViaButtons: View {
    @EnvironmentObject var viaButtons: ButtonsManager
    @EnvironmentObject var device : TelnetManager
    
    @State private var isEditButton = false
    
    let columns1 = Array(repeating: GridItem(.flexible(minimum: 120, maximum: 400)), count: 2)
    
    var body: some View {
        
        ScrollView{
            LazyVGrid(columns: columns1, spacing: 10){
                ForEach(viaButtons.viaButtonsList, id: \.id) { item in
                    
                    ButtonView(item: item)
                        .modifier(PressModifier(tapAction: {
                           device.sendCommand(item, hostInfo: viaButtons.viaHost)
                            AudioServicesPlaySystemSound(3)
                        }, longPressAction: { }, mainColor: item.color1))
                    
                        .contextMenu{
                            Button("Редактировать", action: {
                                viaButtons.viaActiveItem = item
                                isEditButton.toggle()
                            })
                            Button("Удалить", action: {
                                viaButtons.deleteViaItem(item)
                            })
                            
                        }
                }
                
            }
           
        }
        .sheet(isPresented: $isEditButton) {
            NewViaButtonView()
            
        }
        
    }
}

struct ListOfViaButtons_Previews: PreviewProvider {
    static var previews: some View {
        ListOfViaButtons()
    }
}
