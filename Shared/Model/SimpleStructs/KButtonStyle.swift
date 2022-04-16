//
//  KButtonStyle.swift
//  KControl
//
//  Created by ak77m on 18.03.2022.
//

import SwiftUI

struct KButtonStyle : Identifiable, Hashable, Codable, fixButtonStyle { 
    
    var id = UUID()
    var label = ""
    var image = ""
    var description = ""
    var color1 = Color.init(cgColor: CGColor.init(red: 0, green: 0, blue: 0, alpha: 0))
    var kNetDevice = 0
    var kNetId = 0
}


