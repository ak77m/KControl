//
//  BottomView.swift
//  KControl
//
//  Created by ak77m on 22.03.2022.
//

import SwiftUI

struct BottomView: View {
    @EnvironmentObject var log : LogManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Запрос/Ответ :\(log.answers[log.answers.count-1].text)")
                .lineLimit(1)
               
        }
        .font(.footnote)
        .padding(.vertical, 5)
    }
}

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        BottomView()
    }
}
