//
//  ViaBottonView.swift
//  KControl (macOS)
//
//  Created by ak77m on 16.04.2022.
//

import SwiftUI

struct ViaBottomView: View {
    @EnvironmentObject var log : TelnetManager
    //let n =
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ответ  : \(log.answers[log.answers.count-1].text)")
                .textSelection(.enabled)
        }.font(.footnote)
    }
}


struct ViaBottonView_Previews: PreviewProvider {
    static var previews: some View {
        ViaBottomView()
    }
}
