//
//  Manager.swift
//  KControl
//
//  Created by ak77m on 18.03.2022.
//

import Foundation
import SwiftUI

/// To use methods ID and COLOR1 inside generic function
protocol fixButtonStyle {
    var id : UUID { get set}
    var color1 : Color { get set }
}

final class ButtonsManager : ObservableObject {
    /// K-Net view
    @Published var kButtonsList = [KButtonStyle]()
    @Published var kActiveItem = KButtonStyle()
    @Published var kHost = HostInfo() // to change kIpAddress and kHostPassword
    
    @Published var kIpAddress = UserDefaults.standard.string(forKey: "hostIpAddress") ?? "192.168.0.0"
    @Published var kHostPassword = UserDefaults.standard.string(forKey: "hostPassword") ?? ""
    
    /// Via View
    @Published var viaButtonsList = [ViaButtonStyle]()
    @Published var viaActiveItem = ViaButtonStyle()
    @Published var viaHost = HostInfo()
    
    
    /// Local storage (JSON)
    let listStorage = ListStorage()
    private let kListFileName = "ButtonsList.json"
    private let viaListFileName = "ViaButtonsList.json"
    
    var emoji = [String]()
    
    init() {
        loadCustomList()
        emoji = listStorage.buttonsEmoji
        
        viaHost.ipAddress = UserDefaults.standard.string(forKey: "viaIpAddress") ?? "192.168.0.0"
        viaHost.login = UserDefaults.standard.string(forKey: "viaLogin") ?? "su"
        viaHost.password = UserDefaults.standard.string(forKey: "viaPassword") ?? "supass"
        
        kHost.ipAddress = UserDefaults.standard.string(forKey: "hostIpAddress") ?? "192.168.0.0"
        kHost.password = UserDefaults.standard.string(forKey: "hostPassword") ?? ""
    }
    
    // MARK: - Add/Edit/Delete items
    
    func updateOrNewItem() {
        kButtonsList = addItemToArray(kButtonsList, item: kActiveItem)
        _ = listStorage.writeList(kButtonsList, fileName: kListFileName)
    }
    
    
    func updateOrNewViaItem() {
        viaButtonsList = addItemToArray(viaButtonsList, item: viaActiveItem)
        _ = listStorage.writeList(viaButtonsList, fileName: viaListFileName)
    }
    
    private func addItemToArray<T: fixButtonStyle > (_ arrayOfButton : [T], item: T) -> [T] {
        var newItem = true
        var item = item
        var arrayOfButton = arrayOfButton
        
        // Double convert to CGColor because
        // Color can't convert colours like .green/.red/.systemBackground etc
        let tempColor = item.color1.cgColor ?? CGColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        item.color1 = Color.init(cgColor: tempColor)

        // Try to find record with same ID and if ID not found it's a new record
        arrayOfButton.indices.forEach {
            if arrayOfButton[$0].id == item.id {
                arrayOfButton[$0] = item
                newItem = false
            }
        }
        
        if newItem {
            arrayOfButton.append(item)
        }
        return arrayOfButton
    }
    
    
    func deleteItem(_ index: KButtonStyle) {
        kButtonsList = kButtonsList.filter{ $0 != index }
        _ = listStorage.writeList(kButtonsList, fileName: kListFileName)
    }
    
    func deleteViaItem(_ index: ViaButtonStyle) {
        viaButtonsList = viaButtonsList.filter{ $0 != index }
        _ = listStorage.writeList(viaButtonsList, fileName: viaListFileName)
    }
    
    
    // MARK: - Clear array of Button
    func deleteList() {
        kButtonsList = [KButtonStyle]()
        _ = listStorage.writeList(kButtonsList, fileName: kListFileName)
    }
    
    func deleteViaList() {
        viaButtonsList = [ViaButtonStyle]()
        _ = listStorage.writeList(viaButtonsList, fileName: viaListFileName)
    }
    
    // MARK: - Loading and Save array of KButtons
    
    func saveListOfButtons() -> Bool {
        print("saveListOfButtons")
        return listStorage.writeList(kButtonsList, fileName:kListFileName)
    }
    
    private func loadCustomList() {
        kButtonsList = listStorage.readList(kListFileName)
        viaButtonsList = listStorage.readList(viaListFileName)
    }
    
    // MARK: - Save UserDefaults
    func saveDefaults() {
        UserDefaults.standard.set(kIpAddress, forKey: "hostIpAddress")
        UserDefaults.standard.set(kHostPassword, forKey: "hostPassword")
        UserDefaults.standard.set(viaHost.ipAddress, forKey: "viaIpAddress")
        UserDefaults.standard.set(viaHost.login, forKey: "viaLogin")
        UserDefaults.standard.set(viaHost.password, forKey: "viaPassword")
    }
    
    
    
    
}
