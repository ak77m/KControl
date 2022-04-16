//
//  TelnetManager.swift
//  KControl
//
//  Created by ak77m on 30.03.2022.
//

// Example https://dump.video/i/0kaZQ7.mp4

import SwiftUI

final class TelnetManager : ObservableObject {
  
    @Published var commands = [ViaCommand]()
    @Published var answers : [LogStruct] = [LogStruct("Cтарт программы")]
    
    var importCfg = ConfigImport()
    var socket = Telnet()
    
    //var log = LogManager()
    
    init() {
        loadViaCommands()
    }
    
    /// To check field with will be available for edit
    /// проверяем есть ли у команды кастомные поля возвращаем добавленные поля команды
    func checkCommandStatus(_ viaActiveItem: ViaButtonStyle, index: Int) -> (ViaButtonStyle, Bool, Bool, Bool) {
        var p1 = true    // статус запрета на редактирование параметра p1
        var p2 = true    // статус запрета на редактирование параметра p2
        var p3 = true    // статус запрета на редактирование параметра p2
        var activeItem = viaActiveItem
        
        activeItem.cmd = commands[index].cmd
        
        if commands[index].p1.contains("&") { p1 = false } else {
            activeItem.p1 =  commands[index].p1
        }
        
        if commands[index].p2.contains("&") { p2 = false } else {
            activeItem.p2 =  commands[index].p2
        }
        
        if commands[index].p3.contains("&") { p3 = false } else {
            activeItem.p3 =  commands[index].p3
        }
        
        answers.append(LogStruct("Кнопка \(activeItem.cmd) : \(activeItem.p1): \(activeItem.p2)"))
        return (activeItem, p1, p2, p3)
    }
    
    
    func sendCommand(_ buttonCommand: ViaButtonStyle, hostInfo: HostInfo) {
        
        let ip = hostInfo.ipAddress
        let _ = hostInfo.port
        let fullCommandSet = fullCommandString(buttonCommand, hostInfo)
        
        // Send command and get answer
        socket.sendTo(ip, port: 9982, fullCommandSet) {
            let newValue = $0.replacingOccurrences(of: "|", with: " ") //"\n"
            self.answers.append(LogStruct(newValue))
        }
    }
    
    // MARK: - Fixed useful commands in separate view
    func setNewIpAdress(_ host: HostInfo) {
        print("New ip address")
    }
    
    func getHostInfo(_ host: HostInfo) -> HostInfo {
        print("Host info request")
        var currentIpSettings = ViaButtonStyle()
        currentIpSettings.cmd = "IpInfo"
        sendCommand(currentIpSettings, hostInfo: host)
        // IP:192.168.101.16 SUB:255.255.255.0 GAT:192.168.101.1 DNS:192.168.101.1, Host:VIA-GO2

        return HostInfo()
    }

    
    func powerOff(_ host: HostInfo)  {
        print("Power off \(host.ipAddress)")
        var powerOff = ViaButtonStyle()
        powerOff.cmd = "PowerOff"
        sendCommand(powerOff, hostInfo: host)
    }
    
    func reboot(_ host: HostInfo)  {
        print("Reboot \(host.ipAddress)")
        var reboot = ViaButtonStyle()
        reboot.cmd = "Reboot"
        sendCommand(reboot, hostInfo: host)
    }
    
    
    private func fullCommandString(_ cmd: ViaButtonStyle, _ hostInfo: HostInfo) -> [String] {
        var arrayOfCommands = [String]()
        
        let login = hostInfo.login
        let password = hostInfo.password
        let cmd_ = cmd.cmd
        let p1 = cmd.p1
        let p2 = cmd.p2
        
        let firstPart = "<P><UN>\(login)</UN><Pwd>\(password)</Pwd>"
        let loginString = "<Cmd>Login</Cmd><P1></P1><P2></P2>"
        let centerPart = "<Cmd>\(cmd_)</Cmd><P1>\(p1)</P1><P2>\(p2)</P2>"
        let lastPart = "<P3></P3><P4></P4><P5></P5><P6></P6><P7></P7><P8></P8><P9></P9><P10></P10></P>"
        
        arrayOfCommands.append(firstPart + loginString + lastPart)
        arrayOfCommands.append(firstPart + centerPart  + lastPart)
        
        return arrayOfCommands
    }
  
    
    // MARK: - Array of commands
    func loadViaCommands() {
        guard let data = importCfg.getCommandFromData() else { return }
        commands = data
    }

}
