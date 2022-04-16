//
//  LogStruct.swift
//  KControl
//
//  Created by ak77m on 15.04.2022.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}


struct LogStruct : Hashable, Identifiable {
    let id = UUID()
    let date = Date().getFormattedDate(format: "HH:mm:ss")
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
}
