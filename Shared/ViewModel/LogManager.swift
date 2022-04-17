//
//  LogManager.swift
//  KControl
//
//  Created by ak77m on 13.04.2022.
//

import Foundation
import NotificationCenter

//protocol LogsTransferDelegate : AnyObject {
//
//    func addRecordToLog(_ item : String)
//
//}


final class LogManager: ObservableObject {
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(addRecordToLog(notification:)),
                                               name: NSNotification.Name(rawValue: "LogUpdated"), object: nil)
    }
    
    @Published var  answers : [LogStruct] = [LogStruct("Cтарт программы")]
    
    
    @objc  func addRecordToLog(notification: NSNotification) {
        answers.append(LogStruct(notification.object as! String))
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "LogUpdated"), object: nil)
    }
    
}
