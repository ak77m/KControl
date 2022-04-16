//
//  NetworkManager.swift
//  KControl
//
//  Created by ak77m on 21.03.2022.
//

import SwiftUI

final class NetworkManager : ObservableObject {
    
    @Published var response = ""
    @Published var answer = ""
    @Published var configFromDevice = [KButtonStyle]()
    
    var request = Requests()
    var importCfg = ConfigImport()
    
    
    /// To convert and sent comand to K-Net device
    func sendCommand(_ host: String, knet: Int = 0, devID : Int = 0 ) -> Bool {
        let com = "/test.cgx?cmd=BTN%20\(devID),\(knet),R"
        request.fetchRequest(host, command: com) { response,answer in
            DispatchQueue.main.async {
                self.response = response
                self.answer = answer
           }
        }
        return response == "200" ? true : false
    }
    
    /// Func only for K-Net device TODO: move to Model
    func getConfigFromController(_ host: String) {
        let com = "/KramerConf.ini"
        request.fetchRequest(host, command: com, documentType: .plain) { response,answer in
            if response == "200" && !answer.isEmpty {
                let temp = self.importCfg.getConfigFromData(iniData: answer)
                
                 DispatchQueue.main.async {
                     self.response = "Успешно, примените изм."
                     self.configFromDevice = temp
                     
                }
            } else {
                DispatchQueue.main.async {
                    self.response = "Ошибка \(response)"
                }
            }
        }
    }
    
}
