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
        // Вариант 1 без возврата ошибки
        //        Task {
        //            let messages = await fetchMessagesResult()
        //            print(messages)
        //        }
        
        // Вариант 2 с возвратом ошибки
        Task {
            do {
                let messages = try await fetchMessagesResult()
                print(messages)
            } catch {
                print("Failed to load messages with error: \(error.localizedDescription)")
            }
            
            
        }
        
        func fetchMessagesResult(completion: @escaping ([Message]) -> Void) {
            networkService.fetchMessages { message in
                completion(message)
            }
        }
        
        @available(*, renamed: "fetchMessagesResult()")
        // Вариант 1 без возврата ошибки
        
        //    func fetchMessagesResult() async -> [Message] {
        //        return await withCheckedContinuation { continuation in
        //            fetchMessagesResult { messages in
        //                continuation.resume(returning: messages)
        //            }
        //        }
        //    }
        
        // Вариант 2 с возвратом ошибки
        func fetchMessagesResult() async throws -> [Message] {
            return try await withCheckedThrowingContinuation { continuation in
                fetchMessagesResult { messages in
                    if messages.isEmpty {
                        continuation.resume(throwing: FetchError.emptyArray)
                    } else {
                        continuation.resume(returning: messages)
                    }
                }
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
        //            let url = URL(string: "https://hws.dev/user-messages.json")!
        // check empty array case
        let url = URL(string: "https://hws.dev/user-messages.json2")!
        
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

enum FetchError: Error {
    case emptyArray
    
}

extension FetchError: LocalizedError {
    public var errorDescription: String? {
        "Empty array"
    }
}
