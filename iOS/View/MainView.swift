//
//  MainView.swift
//  KControl (iOS)
//
//  Created by ak77m on 22.03.2022.
//

import SwiftUI

struct MainView: View {
  //  @Environment(\.managedObjectContext) private var viewContext
    
    
    init(){
#if os(iOS)
           //Theme.navigationBarColors(background: .darkGray, titleColor: .white)
           UITabBar.appearance().backgroundColor = UIColor.darkGray
           UITabBar.appearance().unselectedItemTintColor = UIColor.white
#endif
        }
    
   // @EnvironmentObject var info : InfoManager
    
    
    @State private var selection = 0
    
    var body: some View {
                TabView(selection: $selection){
                    ListOfButtons()
                        .tabItem {
                            Image(systemName: "rectangle.connected.to.line.below")
                            Text("Управление")
                        }
                   
//                    InfoView()
//                        .tabItem {
//                            Image(systemName: "info.circle")
//                            Text("инфо")
//                        }
                    SetupView()
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Настройка")
                        }
                }
                .navigationViewStyle(StackNavigationViewStyle())
    }
}
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
        }
    }
