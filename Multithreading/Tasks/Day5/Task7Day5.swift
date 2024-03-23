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
        let string = await withTaskGroup(of: String.self) { group -> String in
            // тут добавляем строки в группу
            group.addTask {
                "Hello"
            }
            group.addTask {
                "My"
            }
            group.addTask {
                "Road"
            }
            group.addTask {
                "Map"
            }
            group.addTask {
                "Group"
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
