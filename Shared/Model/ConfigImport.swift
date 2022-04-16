//
//  ConfigImport.swift
//  KControl
//
//  Created by ak77m on 26.03.2022.
//

import SwiftUI

struct ConfigImport {
    
    /// Parsing file KramerCfg.ini
    func getConfigFromData(iniData: String) -> [KButtonStyle] {
        
        var arrayOfButtons = [KButtonStyle]()
        let arrayOfRows = iniData.components(separatedBy: "\n")
        
        //        let temp = arrayOfRows.filter {
        //            $0.contains("[Master") ||
        //            $0.contains("[Slave")  ||
        //            $0.contains("Button Label")  ||
        //            $0.contains("Button Behavior")
        //        }
        
        var deviceID = 0                        // Temporary var for deviceID
        var buttonLabel : [String] = []         // Temporary array for Labels names
        
        for row in arrayOfRows {
            
            // Try to find sections and save device ID
            if row.contains("[Master") || row.contains("[Slave") {
                let separatedString = parseProperties(row, str: ":]")
                deviceID = Int(separatedString) ?? 0
                buttonLabel = []            // New section with new array of Labels
            }
            
            // Create array of Labels for current Section
            if row.contains("Button Label") {
                let value = parseProperties(row, str: "=\r")
                buttonLabel.append(value)
            }
            
            // For each non empty line "Button Behavior" will create KButtonStyle record
            if row.contains("Button Behavior") {
                let value = parseProperties(row, str: "=\r")
                if !value.isEmpty {
                    let btnNumber = Int(parseProperties(row, str: "r=")) ?? 1
                    var labelText = ""
                    if buttonLabel.count != 0 && (btnNumber - 1) <= buttonLabel.count  {
                        labelText = buttonLabel[btnNumber-1]
                        
                    }
                    
                    // In MacOS impossible to use .grey .green etc
                    let tempColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 0)
                    
                    arrayOfButtons.append(KButtonStyle(label: labelText,
                                                       image: "",
                                                       description: "\(deviceID):\(btnNumber)",
                                                       color1: Color.init(cgColor: tempColor),
                                                       kNetDevice: deviceID,
                                                       kNetId: btnNumber))
                }
            }
        }
        return arrayOfButtons
    }
    
    /// To find value between two Char symbols -> Answer is always second record from array
    private func parseProperties (_ line: String, str: String) -> String {
        let set : CharacterSet = CharacterSet.init(charactersIn: str)
        let separatedString = line.components(separatedBy: set)
        return separatedString[1]
    }
    
    func getCommandFromData() -> [ViaCommand]? {
        
        guard let temData = loadConfigFromFile("ViaCommands") else { return nil }
        var ArrayOfData = [ViaCommand]()
        
        var arrayOfRows = temData.components(separatedBy: "\n")
        arrayOfRows = arrayOfRows.filter { $0 != "" }
        
        arrayOfRows.forEach { item in
            var command = ViaCommand()
            let temp = item.components(separatedBy: ":")
            let itemCount = temp.count-1
            
            if itemCount > 0 { command.id = Int(temp[0].trimmingCharacters(in: .whitespaces)) ?? 0 }
            if itemCount >= 1 { command.name = temp[1].trimmingCharacters(in: .whitespaces) }
            if itemCount >= 2 { command.cmd = temp[2].trimmingCharacters(in: .whitespaces) }
            if itemCount >= 3 { command.p1 = temp[3].trimmingCharacters(in: .whitespaces) }
            if itemCount >= 4 { command.p2 = temp[4].trimmingCharacters(in: .whitespaces) }
            if itemCount >= 5 { command.p3 = temp[5].trimmingCharacters(in: .whitespaces) }
            if itemCount >= 6 { command.p4 = temp[6].trimmingCharacters(in: .whitespaces) }
            if itemCount >= 7 { command.p5 = temp[7].trimmingCharacters(in: .whitespaces) }
            
            ArrayOfData.append(command)
        }
        //print(ArrayOfData)
        return ArrayOfData
    }
    
    /// load commands
   private func loadConfigFromFile(_ fileName: String) -> String? {
            if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt") {
                do {
                    let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                    return text2
                }
                catch { return nil }
            }
        return nil
    }
    
    // MARK: Temp func
    /// function for future work with file
    func saveConfigToFile(_ data: String) -> Bool {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent("KramerConf.ini")
        if let stringData = data.data(using: .utf8) {
            try? stringData.write(to: path)
        } else { return false }
        
        return true
    }
    
    
}
