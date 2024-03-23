//
//  Task5Day5.swift
//  Multithreading
//
//  Created by Dmitry on 23.03.2024.
//

import UIKit

class Task5Day5: UIViewController {
    
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let messages = await fetchMessagesResult()
            print(messages)
        }
        
    }
    
    func fetchMessagesResult(completion: @escaping ([Message]) -> Void) {
        networkService.fetchMessages { message in
            completion(message)
        }
    }
    
    @available(*, renamed: "fetchMessagesResult()")
    func fetchMessagesResult() async -> [Message] {
        return await withCheckedContinuation { continuation in
            fetchMessagesResult { messages in
                continuation.resume(returning: messages)
            }
        }
    }
    
}

struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let message: String
}


class NetworkService {
    
    func fetchMessages(completion: @escaping ([Message]) -> Void) {
        let url = URL(string: "https://hws.dev/user-messages.json")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                    completion(messages)
                    return
                }
            }
            
            completion([])
        }
        .resume()
    }
}
