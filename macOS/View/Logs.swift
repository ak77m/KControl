//
//  Logs.swift
//  KControl
//
//  Created by ak77m on 13.04.2022.
//

import SwiftUI

struct Logs: View {
    @EnvironmentObject var log : TelnetManager
    @State private var selected = Set<LogStruct.ID>()
    
    var body: some View {
        // Only for MacOS 12
        Table(log.answers, selection: $selected) {
            TableColumn("Время", value: \.date).width(60)
            //TableColumn("Ответ устройства", value: \.text)
            TableColumn("Ответ устройства") { Text($0.text).lineLimit(nil) }
        }
        .textSelection(.enabled)
        
    }
}

