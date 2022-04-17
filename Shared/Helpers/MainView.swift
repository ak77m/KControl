//
//  MainView.swift
//  KControl
//
//  Created by ak77m on 18.03.2022.
//

import SwiftUI

struct MainView: View {

    
#if os(iOS)
    init(){
        //Theme.navigationBarColors(background: .darkGray, titleColor: .white)
        UITabBar.appearance().backgroundColor = UIColor.darkGray
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
#endif
    
    
    
    @State private var selection = 0
    var body: some View {
        
        TabView(selection: $selection){
            
            VStack(alignment: .leading){
#if os(macOS)
                ControlView()
#endif
                ListOfButtons()
                BottomView()
            }
            .tag(0)
            .padding(.horizontal)
            .tabItem {
                Image(systemName: "rectangle.connected.to.line.below")
                Text(" K-Net ")
            }
            
            VStack(alignment: .leading){
#if os(macOS)
                ViaTopView()
#endif
                ListOfViaButtons()
                BottomView()
            }
            .tag(1)
            .padding(.horizontal)
            .tabItem {
                Image(systemName: "rectangle.connected.to.line.below")
                Text(" VIA Control ")
            }
            
            VStack(alignment: .leading){
                Logs()
            }
            .tag(2)
            .padding(.horizontal)
            .tabItem {
                Image(systemName: "info.circle")
                Text(" Лог VIA ")
            }
            
            VStack(alignment: .leading){
                SettingsView()
            }
            .tag(3)
            .padding(.horizontal)
            .tabItem {
                Image(systemName: "gear")
                Text(" Настройка ")
            }
        }
        
#if os(macOS)
        .frame(minWidth: 400, idealWidth: 400, maxWidth: 400,
               minHeight: 550, idealHeight: 550, maxHeight: .infinity)
#else
        .navigationViewStyle(StackNavigationViewStyle())
#endif
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
