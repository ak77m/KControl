//
//  ViaButtonStyle.swift
//  KControl (macOS)
//
//  Created by ak77m on 29.03.2022.
//

import SwiftUI

struct ViaButtonStyle : Identifiable, Hashable, Codable, fixButtonStyle {
    
    var id =  UUID()
    var label = ""
    var image = ""
    var description =  ""
    var color1 = Color.init(cgColor: CGColor.init(red: 0, green: 0, blue: 0, alpha: 0))
    var commandId = 0
    
    /// Min set for VIA comand string
    var cmd = ""
    var p1 = ""
    var p2 = ""
    var p3 = ""
}


