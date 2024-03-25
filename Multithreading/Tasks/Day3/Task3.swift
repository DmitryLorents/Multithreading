//
//  Task3.swift
//  Multithreading
//
//  Created by Dmitry on 21.03.2024.
//

import UIKit

class Task3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let serialQueue = DispatchQueue(label: "com.example.myQueue")

        serialQueue.async {
           serialQueue.async {
               print("This will never be printed.")
           }
        }
    }
    
}
// Здесь наблюдается deadlock потому что последовательная очередь сама на себе вызывает метод sync
