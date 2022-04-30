//
//  Telnet.swift
//  KControl
//
//  Created by ak77m on 12.04.2022.
//

import Foundation
import Network

final class Telnet {
    
    private var connection: NWConnection?
    private var answer = ""
   
    func sendTo(_ host: String, port: NWEndpoint.Port, _ command: [String], param: NWParameters = .tcp, completion: @escaping ((String) -> Void))  {
        self.answer = "" // Новый запрос предполагает обнуление старого ответа
        let host = NWEndpoint.Host(host)
        
        self.connection = NWConnection(host: host, port: port, using: param)
     
        self.connection?.stateUpdateHandler = { [weak self] (newState) in
            switch (newState) {
            case .ready:
                command.forEach { item in //To send array of commands
                    print(item)
                    self?.setCommand(item) // отправляем массив команд, ошибки не обрабатываем
                }
                self?.getAnswer { self?.answer = $0 }
                
                // Если не ждать то результатом будет первое выполнение функции getAnswer, а она выполняется несколько раз
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    completion(self?.answer ?? "Пусто")
                }
                
            case .setup:
                print("State: Setup\n")
                break
            case .cancelled:
                print("State: Cancelled\n")
                break
            case .preparing:
                self?.answer = "preparing..."
                //completion(self?.answer)
                break
            default:
               // self.answer = "Ошибка подключения "
                completion(self?.answer ?? "")
                break
            }
        }
        self.connection?.start(queue: .global())

    }
    
    // MARK: - Send command and get answer
    private func setCommand(_ content: String) {
        
        let content = (content+"\r\n").data(using: .utf8)
        
        self.connection?.send(content: content, completion: .contentProcessed(({ (NWError) in
            if (NWError != nil) {
                print("Ошибка подключения \(NWError?.localizedDescription ?? "")")
            }
        })))
      
    }
    
    private func getAnswer(completion: @escaping ((String) -> Void))  {
        connection?.receive(minimumIncompleteLength: 1, maximumLength: 65536, completion: { [weak self] (data, _, isComplete, error) in
                if let data = data, !data.isEmpty {
                    DispatchQueue.main.async {
                        guard let answer = String(data: data, encoding: .utf8) else { return }
                        if !answer.isEmpty {
                            print("Aswer: \(answer)")
                            completion(answer)
                            
                        }
                        return
                    }
                }
                if isComplete {
                    print("----- isComplete")
                    return
                } else if error != nil {
                    return
                } else {
                    // если не повторить запрос на себя пропускается ответ
                    // Если использовать self.answer += $0 то получим накопительный ответ включая логин
                    self?.getAnswer() { self?.answer = $0 }
                }
            })
    }

}

