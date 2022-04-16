//
//  KControlApp.swift
//  Shared
//
//  Created by ak77m on 18.03.2022.
//

import SwiftUI

@main
struct KControlApp: App {
    @StateObject var kButtons = ButtonsManager()
    @StateObject var network = NetworkManager()
    @StateObject var via = TelnetManager()
   // @StateObject var log = LogManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(kButtons)
                .environmentObject(network)
                .environmentObject(via)
                //.environmentObject(log)
        }
        
       #if os(macOS)
        // Its works but sometimes crash system 
//        Settings {
//            SettingsView()
//        }
        #endif
        
        
    }
}
