//
//  ListStorage.swift
//  KControl
//
//  Created by ak77m on 27.03.2022.
//

import Foundation

struct ListStorage {
    
    let buttonsEmoji = " 🔭📽🎛🖥⚡️🎙📺🎚📹📸📀📡🔑🌎🏃‍♂️🎬👨‍🏫🎤⏱🔌💡🔬🔓🔼🔽◀️▶️⏸⏯⏹⏺⬅️⬆️⬇️➡️🔀🔴🟠🟡🟢🔵🟣🔺🔻🔇🔊🔉🚫❌⭕️🔦🕯💾0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣9️⃣🔟🔄".map {
        String($0)
    }
    
    /// Generic for use both lists KButtonStyle and ViaButtonStyle
    func readList<T: Decodable>(_ fileName: String) -> [T] { //KButtonStyle
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return []}
        do {
            let filePath = dir.appendingPathComponent(fileName)
            let data = try Data(contentsOf: filePath, options: .mappedIfSafe)
            
            let decodedData = try JSONDecoder().decode([T].self, from: data)
                return decodedData
            
        } catch {
            print("Failed to load JSON data: \(error.localizedDescription)")
        }
        return []
    }
    
    /// Generic for use both lists KButtonStyle and ViaButtonStyle
    func writeList<T: Encodable>(_ list: [T], fileName: String) -> Bool {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return false }
            //print("Directory \(dir)")
            let fileURL = dir.appendingPathComponent(fileName)
            let json = try? JSONEncoder().encode(list)
            do {
                try json!.write(to: fileURL)
                return true
            }
            catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
                return false
            }
    }
    
}
