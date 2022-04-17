//
//  Logs.swift
//  KControl
//
//  Created by ak77m on 13.04.2022.
//

import SwiftUI

struct Logs: View {
    @EnvironmentObject var log : LogManager
    @State private var selected = Set<LogStruct.ID>()
    
    var body: some View {
        
#if os(macOS)
        Table(log.answers, selection: $selected) {
            TableColumn("Время", value: \.date).width(70)
            TableColumn("Ответ устройства") { Text($0.text).lineLimit(nil) }
        }
        .textSelection(.enabled)
#else
        List {
            ForEach(log.answers, id: \.self) { item in
                HStack{
                    VStack(alignment: .leading){
                        Text(item.date)
                    }.frame(width: 70)
                    
                    Divider()
                    VStack(alignment: .leading){
                        Text(item.text)
                    }
                }
            }.font(.footnote)
        }
#endif
        
        
        
        
    }
}

