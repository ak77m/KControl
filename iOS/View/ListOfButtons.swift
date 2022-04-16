//
//  ListOfButtons.swift
//  KControl (iOS)
//
//  Created by ak77m on 22.03.2022.
//

import SwiftUI

struct ListOfButtons: View {
    @EnvironmentObject var kButtons: ButtonsManager
    @EnvironmentObject var network : NetworkManager
    
    @State private var isPresented = false
    @State private var countValue = 2
    
    let columns = Array(repeating: GridItem(
        .flexible(minimum: 100, maximum: 400)),count: 2)
    
    var body: some View {
        
        NavigationView{
                LazyVGrid(columns: columns, spacing: 10){
                    ForEach(kButtons.kButtonsList, id: \.id) { item in
                        
                        ButtonView(item: item)
                            .modifier(PressModifier(tapAction: {
                                _ = network.sendCommand(kButtons.kIpAddress, knet: item.kNetDevice, devID : item.kNetId)
                            },
                            longPressAction: {
                                // edit record
                                //kButtons.activeItem = item
                                //isPresented.toggle()
                            }, mainColor: item.color1))
                            .contextMenu{
                                Button("Редактировать", action: {
                                    kButtons.kActiveItem = item
                                    isPresented.toggle()
                                })
                                Button("Удалить", action: {
                                    kButtons.deleteItem(item)
                                })
                                
                            }
                    }
                    
                }
                
                .navigationTitle(kButtons.kIpAddress)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    Button(action: {
                        // new record
                        kButtons.kActiveItem = KButtonStyle()
                        isPresented.toggle()
                    }, label: {Image(systemName: "plus.circle")})
                }
        }
        .padding(.horizontal, 5)
        
        .fullScreenCover(isPresented: $isPresented) {
            //sheet(isPresented: $isPresented) {
            NewButton()
        }
        
    }
}

struct ListOfButtons_Previews: PreviewProvider {
    static var previews: some View {
        ListOfButtons()
    }
}
