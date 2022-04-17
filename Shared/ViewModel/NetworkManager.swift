//
//  NetworkManager.swift
//  KControl
//
//  Created by ak77m on 21.03.2022.
//

import SwiftUI

final class NetworkManager : ObservableObject {
   
    @Published var configFromDevice = [KButtonStyle]()
    
    private var request = Requests()
    private var importCfg = ConfigImport()
    
    
    /// To convert and sent comand to K-Net device
    func sendCommand(_ host: String, knet: Int = 0, devID : Int = 0 )  {
        let com = "/test.cgx?cmd=BTN%20\(devID),\(knet),R"
        request.fetchRequest(host, command: com) { response,answer in
            DispatchQueue.main.async {
                let newValue = "\(response) : \(com)"
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LogUpdated"), object: newValue)
           }
        }
        
        
    }
    
    /// Func only for K-Net device TODO: move to Model
    func getConfigFromController(_ host: String) {
        let com = "/KramerConf.ini"
        request.fetchRequest(host, command: com, documentType: .plain) { response,answer in
            if response == "200" && !answer.isEmpty {
                let temp = self.importCfg.getConfigFromData(iniData: answer)
                
                 DispatchQueue.main.async {
                     let newValue = "Импорт успешен, примените изменения"
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LogUpdated"), object: newValue)
                     self.configFromDevice = temp
                     
                }
            } else {
                DispatchQueue.main.async {
                    let newValue = "Ошибка \(response)"
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LogUpdated"), object: newValue)
                }
            }
        }
    }
    
}
