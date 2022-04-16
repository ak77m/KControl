//
//  BottomView.swift
//  KControl
//
//  Created by ak77m on 22.03.2022.
//

import SwiftUI

struct BottomView: View {
    @EnvironmentObject  var network : NetworkManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Response: \(network.response)")
            Text("Answer  : \(network.answer)")
        }.font(.footnote)
    }
}

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        BottomView()
    }
}
