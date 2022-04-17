//
//  ListOfViaButtons.swift
//  KControl (iOS)
//
//  Created by ak77m on 17.04.2022.
//

import SwiftUI

struct ListOfViaButtons: View {
    @EnvironmentObject var viaButtons: ButtonsManager
    @EnvironmentObject var device : TelnetManager
    
    @State private var isEditButton = false
    @State private var powerButton = false
    
    let columns1 = Array(repeating: GridItem(.flexible(minimum: 120, maximum: 400)), count: 2)
    
    var body: some View {
        
        NavigationView{
            LazyVGrid(columns: columns1, spacing: 10){
                ForEach(viaButtons.viaButtonsList, id: \.id) { item in
                    
                    ButtonView(item: item)
                        .modifier(PressModifier(tapAction: {
                           device.sendCommand(item, hostInfo: viaButtons.viaHost)
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
            .navigationTitle(viaButtons.viaHost.ipAddress)
            .navigationBarTitleDisplayMode(.inline)

            .toolbar{
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // new record
                        viaButtons.viaActiveItem = ViaButtonStyle()
                        isEditButton.toggle()
                    }, label: {Image(systemName: "plus.circle")})
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        powerButton.toggle()
                    }, label: {Image(systemName: "power.circle")})
                }
                
                
            }
           
        }
        .sheet(isPresented: $isEditButton) {
            NewViaButtonView()
        }
        .sheet(isPresented: $powerButton) {
            PowerManagerView()
        }
        
    }
}

struct ListOfViaButtons_Previews: PreviewProvider {
    static var previews: some View {
        ListOfViaButtons()
    }
}
