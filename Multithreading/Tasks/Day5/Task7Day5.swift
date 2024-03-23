//
//  Task7Day5.swift
//  Multithreading
//
//  Created by Dmitry on 23.03.2024.
//

import UIKit

class Task7Day5: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await printMessage()
        }
    }
    
    func printMessage() async {
        let messages = ["Hello", "My", "Road", "Map", "Group"]
        let string = await withTaskGroup(of: String.self) { group -> String in
            // тут добавляем строки в группу
            for message in messages {
                group.addTask {
                    message
                }
            }
            var collected = [String]()
            
            for await value in group {
                collected.append(value)
            }
            
            return collected.joined(separator: " ")
        }
        
        print(string)
    }
}
