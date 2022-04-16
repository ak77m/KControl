//
//  InfoView.swift
//  KControl (iOS)
//
//  Created by ak77m on 22.03.2022.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var network : NetworkManager
    var body: some View {
        
        VStack{
            Text("На реконструкции")
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
