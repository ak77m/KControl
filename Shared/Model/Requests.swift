//
//  Requests.swift
//  KControl
//
//  Created by ak77m on 18.03.2022.
//

import Foundation

final class Requests {
    
    func fetchRequest(_ host: String,
                      method: String = "GET",
                      transportProtocol: String = "HTTP",
                      command: String,
                      documentType: NSAttributedString.DocumentType = .html,
                      _ completion: @escaping (_ response: String, _ answer: String) -> ())   {
        
        let requestString = "\(transportProtocol)://\(host)\(command)".replacingOccurrences(of: " ", with: "")
        guard let requestUrl = URL(string: requestString) else {return completion("Ошибка в строке адреса","")}
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method
        request.timeoutInterval = 3

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            var responseCode = 404
            
            if error != nil { completion("404", "") }
            if let response = response as? HTTPURLResponse { responseCode = response.statusCode}

            if let data = data {
            let decoded = try? NSAttributedString(data: data, options: [
                        .documentType: documentType,
                        .characterEncoding: String.Encoding.utf8.rawValue
                        ], documentAttributes: nil).string
                completion(String(responseCode), decoded ?? "")
            }
        }
        task.resume()
    }


}
